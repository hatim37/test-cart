package com.ecom.testcart.dto;

import lombok.Data;

@Data
public class AddProductInCartDto {
    private Long userId;
    private Long productId;
    private String option;
    private Long quantity;
}
