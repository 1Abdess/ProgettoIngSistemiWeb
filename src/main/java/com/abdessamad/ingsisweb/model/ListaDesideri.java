package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;
import java.sql.Timestamp;

@Data
@Entity
@Table(name = "lista_desideri")
public class ListaDesideri {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "email_utente", referencedColumnName = "email")
    @ToString.Exclude
    private Utente utente;

    @ManyToOne
    @JoinColumn(name = "id_prodotto", referencedColumnName = "id")
    private Prodotto prodotto;

    @Column(name = "data_creazione")
    private Timestamp dataCreazione;
}
