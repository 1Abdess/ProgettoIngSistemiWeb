package com.abdessamad.ingsisweb.model;

import lombok.Data;
import jakarta.persistence.*;
import lombok.ToString;

@Data
@Entity
@Table(name = "coupon_ordine")
public class CouponOrdine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_ordine", referencedColumnName = "id", nullable = true)
    @ToString.Exclude  // Evita la ricorsione infinita se l'ordine ha un carrello
    private Ordine ordine;

    @ManyToOne
    @JoinColumn(name = "id_carrello", referencedColumnName = "id", nullable = true)
    @ToString.Exclude  // Evita la ricorsione infinita se il carrello ha coupon
    private Carrello carrello;

    @ManyToOne
    @JoinColumn(name = "id_coupon", referencedColumnName = "id")
    private Coupon coupon;
}
