package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UtenteRepository extends JpaRepository<Utente, String> {

    // Query derivata per cercare l'utente tramite email
    Optional<Utente> findByEmail(String email);
}
