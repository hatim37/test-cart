package com.ecom.testcart.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class QrCodeDto {
    private String code;
    private String name;
    private String type;
    private String quantity;
    private String commande;
    private String client;
    private String decrypt;
}
