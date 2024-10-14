package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "ordine")
public class Ordine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "email_utente", referencedColumnName = "email")
    private Utente utente;

    @Column(name = "totale")
    private BigDecimal totale;

    @Column(name = "stato_ordine")
    private String statoOrdine;

    @Column(name = "indirizzo_spedizione")
    private String indirizzoSpedizione;

    @Column(name = "data_creazione")
    private Timestamp dataCreazione;

    @OneToMany(mappedBy = "ordine", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<ArticoloOrdine> articoli = new ArrayList<>();

}
