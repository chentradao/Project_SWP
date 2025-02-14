package service;

import model.Category;
import repository.CategoryRepository;
import java.util.List;

public class CategoryService {
    private final CategoryRepository categoryRepository = new CategoryRepository();

    public List<Category> listCategories() {
        return categoryRepository.getAllCategories();
    }
}
