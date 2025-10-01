package com.ecom.testcart.clients;

import com.ecom.testcart.model.Product;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name = "products-service", url = "http://localhost:8091/api")
public interface ProductRestClient {

    @GetMapping("/_internal/productFindById/{id}")
    @CircuitBreaker(name="product", fallbackMethod = "getDefaultProductFindById")
    Product findById(@RequestHeader("Authorization") String authorization, @PathVariable Long id);

    default Product getDefaultProductFindById(String authorization,Long id, Exception e) {
        Product product = new Product();
        product.setId(null);
        product.setName("non trouvé");
        return product;
    }

}
