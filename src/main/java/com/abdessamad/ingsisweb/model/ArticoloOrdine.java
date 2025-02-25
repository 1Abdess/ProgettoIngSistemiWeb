package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Data
@Entity
@Table(name = "articolo_ordine")
public class ArticoloOrdine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_ordine", referencedColumnName = "id")
    @ToString.Exclude
    private Ordine ordine;

    @ManyToOne
    @JoinColumn(name = "id_prodotto", referencedColumnName = "id")
    private Prodotto prodotto;


    @Column(name = "quantita")
    private int quantita;

    @Column(name = "prezzo")
    private BigDecimal prezzo;
}