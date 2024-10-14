package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;

@Data
@Entity
@Table(name = "articolo_carrello")
public class ArticoloCarrello {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_carrello", referencedColumnName = "id")
    @ToString.Exclude
    private Carrello carrello;

    @ManyToOne
    @JoinColumn(name = "id_prodotto", referencedColumnName = "id")
    private Prodotto prodotto;

    @Column(name = "quantita")
    private int quantita;
}