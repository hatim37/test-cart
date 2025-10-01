package com.ecom.testcart.entity;


import com.ecom.testcart.dto.CartItemsDto;
import com.ecom.testcart.model.Order;
import com.ecom.testcart.model.Product;
import com.ecom.testcart.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class CartItems {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long price;
    private Long quantity;
    @Transient
    private Product product;
    private Long productId;
    @Transient
    private User user;
    private Long userId;
    @Transient
    @JsonIgnore
    private Order order;
    private Long orderId;
    @Lob
    @Column(columnDefinition = "longblob")
    private byte[] qrCode;


    public CartItemsDto getCartDto() {
        CartItemsDto cartItemsDto = new CartItemsDto();
        cartItemsDto.setId(id);
        cartItemsDto.setOrderId(orderId);
        cartItemsDto.setPrice(price);
        cartItemsDto.setQuantity(quantity);
        cartItemsDto.setProductId(productId);
        cartItemsDto.setProductName(product.getName());
        cartItemsDto.setUserId(userId);
        cartItemsDto.setReturnedImg(product.getImg());
        cartItemsDto.setQrCode(qrCode);
        return cartItemsDto;
    }
}
