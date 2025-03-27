package service;

import java.util.List;
import java.util.Map;
import entity.PaginatedResponse;
import entity.ProductResponse;
import model.ProductRepository;

public class ProductService {

    private final ProductRepository productRepository = new ProductRepository();

    public PaginatedResponse<ProductResponse> listProductsByCategory(int categoryId, int page, int pageSize, Map<String, String> filters, String sortBy, String sortOrder) {
        List<ProductResponse> products = productRepository.findByCategory(categoryId, page, pageSize, filters, sortBy, sortOrder);
        int total = productRepository.countByCategory(categoryId, filters);
        int totalPages = (int) Math.ceil((double) total / pageSize);
        return new PaginatedResponse<>(products, page, pageSize, total, totalPages);
    }

    public List<String> getAvailableSizes() {
        return productRepository.findAvailableSizesByCategory();
    }
     public List<String> getAvailableColors() {
        return productRepository.getDistinctColors();
    }
}
