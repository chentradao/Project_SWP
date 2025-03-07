package Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Helper class for handling image uploads in web applications
 * @author PCMSI
 */
public class UploadImage {
    private static final Logger LOGGER = Logger.getLogger(UploadImage.class.getName());
    private static final Set<String> ALLOWED_EXTENSIONS = new HashSet<>(Arrays.asList("jpg", "jpeg", "png"));
    private static final int BUFFER_SIZE = 8192;

    /**
     * Uploads an image file from a multipart request
     * 
     * @param request The HTTP servlet request containing the file
     * @param location The relative folder path to store the uploaded file
     * @return The filename of the uploaded file, or empty string if upload failed
     * @throws IOException If an I/O error occurs
     */
    public String uploadFile(HttpServletRequest request, String location) throws IOException {
        String fileName = "";
        
        try {
            // Kiểm tra xem request có phải là multipart hay không
            String contentType = request.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
                LOGGER.log(Level.WARNING, "Request không phải là multipart/form-data: {0}", contentType);
                System.out.println("Lỗi: Form phải có thuộc tính enctype='multipart/form-data'");
                return "";
            }

            // Chuẩn bị thư mục lưu trữ
            String applicationPath = request.getServletContext().getRealPath("");
            String directoryPath = applicationPath + File.separator + location;
            
            // Tạo thư mục nếu chưa tồn tại
            File directory = new File(directoryPath);
            if (!directory.exists()) {
                LOGGER.log(Level.INFO, "Đang tạo thư mục: {0}", directoryPath);
                if (directory.mkdirs()) {
                    System.out.println("Đã tạo thư mục: " + directoryPath);
                } else {
                    LOGGER.log(Level.SEVERE, "Không thể tạo thư mục: {0}", directoryPath);
                    return "";
                }
            }
            
            // Lấy file từ request
            try {
                Part filePart = request.getPart("photo");
                if (filePart == null || filePart.getSize() <= 0) {
                    LOGGER.log(Level.WARNING, "Không có file hoặc file rỗng");
                    return "";
                }
                
                // Lấy tên file gốc
                String originalFileName = getFileName(filePart);
                if (originalFileName == null || originalFileName.isEmpty()) {
                    LOGGER.log(Level.WARNING, "Tên file không hợp lệ");
                    return "";
                }
                
                // Kiểm tra phần mở rộng file
                String extension = getFileExtension(originalFileName);
                if (!ALLOWED_EXTENSIONS.contains(extension.toLowerCase())) {
                    LOGGER.log(Level.WARNING, "Loại file không hợp lệ: {0}. Chỉ chấp nhận: jpg, jpeg, png", extension);
                    System.out.println("File không hợp lệ: " + originalFileName + ". Chỉ chấp nhận JPG, JPEG, PNG");
                    return "";
                }
                
                // Tạo tên file mới để tránh trùng lặp
                fileName = UUID.randomUUID().toString() + "." + extension;
                String filePath = directoryPath + File.separator + fileName;
                
                System.out.println("Đang lưu file tại: " + filePath);
                
                // Lưu file
                try (InputStream inputStream = filePart.getInputStream();
                     OutputStream outputStream = new FileOutputStream(filePath)) {
                    
                    byte[] buffer = new byte[BUFFER_SIZE];
                    int bytesRead;
                    
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    
                    LOGGER.log(Level.INFO, "File đã được lưu thành công: {0}", filePath);
                    System.out.println("Tải lên thành công: " + originalFileName + " → " + fileName);
                }
            } catch (ServletException e) {
                LOGGER.log(Level.SEVERE, "Lỗi khi xử lý multipart/form-data", e);
                System.out.println("Lỗi: Form phải có thuộc tính enctype='multipart/form-data'");
                return "";
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi tải lên", e);
            System.out.println("Lỗi tải lên: " + e.getMessage());
            return "";
        }
        
        return fileName;
    }

    /**
     * Trích xuất tên file gốc từ phần tải lên
     */
    public String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        System.out.println("Content-Disposition: " + contentDisposition);
        
        for (String content : contentDisposition.split(";")) {
            content = content.trim();
            if (content.startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "";
    }

    /**
     * Trích xuất phần mở rộng từ tên file
     */
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex != -1 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex + 1).toLowerCase();
        }
        return "";
    }
}