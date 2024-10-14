package com.abdessamad.ingsisweb.model;

import lombok.Data;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "prodotto")
public class Prodotto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "nome")
    private String nome;

    @Column(name = "descrizione")
    private String descrizione;

    @Column(name = "prezzo")
    private BigDecimal prezzo = BigDecimal.ZERO; // Inizializzazione a ZERO

    @Column(name = "marchio")
    private String marchio;

    @Column(name = "categoria")
    private String categoria;

    @Column(name = "quantita_magazzino")
    private int quantitaMagazzino;

    @Column(name = "in_promozione")
    private boolean inPromozione;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "bloccato")
    private boolean bloccato;
}
