package com.abdessamad.ingsisweb.model;

import lombok.Data;
import lombok.ToString;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "utente")
public class Utente {
    @Id
    @Column(name = "email")
    private String email;

    @Column(name = "nome_utente")
    private String nomeUtente;

    @Column(name = "password")
    private String password;

    @Column(name = "ruolo")
    private String ruolo;

    @Column(name = "data_creazione")
    private LocalDateTime dataCreazione = LocalDateTime.now();

    @Column(name = "bloccato")
    private boolean bloccato;
}
