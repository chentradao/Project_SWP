const host = "https://provinces.open-api.vn/api/";

// Gọi API để lấy danh sách tỉnh/thành phố
var callAPI = (api) => {
    return axios.get(api)
        .then((response) => {
            if (response.data && Array.isArray(response.data)) {
                renderData(response.data, "city");
                // Chọn lại giá trị đã lưu cho "Tỉnh/Thành phố"
                const savedCity = document.getElementById("savedCity") ? document.getElementById("savedCity").value : "";
                if (savedCity) {
                    $("#city option").each(function() {
                        if ($(this).val() === savedCity) {
                            $(this).prop("selected", true);
                            $("#city").trigger("change");
                        }
                    });
                }
            } else {
                console.error("Dữ liệu tỉnh/thành phố không hợp lệ:", response.data);
            }
        })
        .catch((error) => {
            console.error("Lỗi khi gọi API tỉnh/thành phố:", error);
        });
};

// Gọi API để lấy danh sách quận/huyện
var callApiDistrict = (api) => {
    return axios.get(api)
        .then((response) => {
            if (response.data && response.data.districts && Array.isArray(response.data.districts)) {
                renderData(response.data.districts, "district");
                // Chọn lại giá trị đã lưu cho "Quận/Huyện"
                const savedDistrict = document.getElementById("savedDistrict") ? document.getElementById("savedDistrict").value : "";
                if (savedDistrict) {
                    setTimeout(() => {
                        $("#district option").each(function() {
                            if ($(this).val() === savedDistrict) {
                                $(this).prop("selected", true);
                                $("#district").trigger("change");
                            }
                        });
                    }, 1000); // Đợi 1 giây để dữ liệu được điền
                }
            } else {
                console.error("Dữ liệu quận/huyện không hợp lệ:", response.data);
                $("#district").html('<option value="">Quận / Huyện (Không có dữ liệu)</option>');
            }
        })
        .catch((error) => {
            console.error("Lỗi khi gọi API quận/huyện:", error);
            $("#district").html('<option value="">Quận / Huyện (Lỗi API)</option>');
        });
};

// Gọi API để lấy danh sách phường/xã
var callApiWard = (api) => {
    return axios.get(api)
        .then((response) => {
            if (response.data && response.data.wards && Array.isArray(response.data.wards)) {
                renderData(response.data.wards, "ward");
                // Chọn lại giá trị đã lưu cho "Phường/Xã"
                const savedWard = document.getElementById("savedWard") ? document.getElementById("savedWard").value : "";
                if (savedWard) {
                    setTimeout(() => {
                        $("#ward option").each(function() {
                            if ($(this).val() === savedWard) {
                                $(this).prop("selected", true);
                            }
                        });
                    },0); // Đợi 2 giây để dữ liệu được điền
                }
            } else {
                console.error("Dữ liệu phường/xã không hợp lệ:", response.data);
                $("#ward").html('<option value="">Phường / Xã (Không có dữ liệu)</option>');
            }
        })
        .catch((error) => {
            console.error("Lỗi khi gọi API phường/xã:", error);
            $("#ward").html('<option value="">Phường / Xã (Lỗi API)</option>');
        });
};

// Hiển thị dữ liệu vào dropdown
var renderData = (array, select) => {
    let row = '<option value="">Chọn</option>';
    array.forEach(element => {
        row += `<option data-id="${element.code}" value="${element.name}">${element.name}</option>`;
    });
    document.querySelector("#" + select).innerHTML = row;
};

// Gọi API tỉnh/thành phố khi trang được tải
$(document).ready(function() {
    callAPI('https://provinces.open-api.vn/api/?depth=1');
});

// Sự kiện thay đổi tỉnh/thành phố
$("#city").on("change", function() {
    const selectedCityId = $(this).find(':selected').data('id');
    if (selectedCityId) {
        $("#district").html('<option value="">Quận / Huyện</option>');
        $("#ward").html('<option value="">Phường / Xã</option>');
        callApiDistrict(host + "p/" + selectedCityId + "?depth=2");
    } else {
        $("#district").html('<option value="">Quận / Huyện</option>');
        $("#ward").html('<option value="">Phường / Xã</option>');
    }
});

// Sự kiện thay đổi quận/huyện
$("#district").on("change", function() {
    const selectedDistrictId = $(this).find(':selected').data('id');
    if (selectedDistrictId) {
        $("#ward").html('<option value="">Phường / Xã</option>');
        callApiWard(host + "d/" + selectedDistrictId + "?depth=2");
    } else {
        $("#ward").html('<option value="">Phường / Xã</option>');
    }
});