package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "carrello")
public class Carrello {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "email_utente", referencedColumnName = "email")
    private Utente utente;

    @Column(name = "data_creazione")
    private Timestamp dataCreazione;

    @OneToMany(mappedBy = "carrello", fetch = FetchType.EAGER)
    @ToString.Exclude  // Evita la ricorsione infinita
    private List<ArticoloCarrello> articoli = new ArrayList<>();

    @OneToMany(mappedBy = "carrello", fetch = FetchType.EAGER)
    @ToString.Exclude  // Evita la ricorsione infinita
    private List<CouponOrdine> couponApplicati;
}
