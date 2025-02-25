package com.abdessamad.ingsisweb.model;

import lombok.Data;
import jakarta.persistence.*;
import java.sql.Date;

@Data
@Entity
@Table(name = "coupon")
public class Coupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "codice")
    private String codice;

    @Column(name = "percentuale_sconto")
    private double percentualeSconto;

    @Column(name = "valido_fino_a")
    private Date validoFinoA;

    @Column(name = "attivo")
    private boolean attivo;
}
