package com.ecom.testcart.repository;

import com.ecom.testcart.entity.CartItems;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;


public interface CartRepository extends JpaRepository<CartItems, Long> {
    List<CartItems> findByOrderId(Long orderId);

    Optional<CartItems> findByProductIdAndOrderIdAndUserId(Long productId, Long orderId, Long userId);

    List<CartItems> findByQrCodeIsNotNull();
}
