package com.abdessamad.ingsisweb.model;

import lombok.Data;
import jakarta.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "tracciamento_ordine")
public class TracciamentoOrdine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_ordine", referencedColumnName = "id")
    private Ordine ordine;

    @Column(name = "stato")
    private String stato;

    @Column(name = "data_aggiornamento")
    private Timestamp dataAggiornamento;
}
