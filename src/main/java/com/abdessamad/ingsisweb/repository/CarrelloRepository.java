package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Carrello;
import com.abdessamad.ingsisweb.model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface CarrelloRepository extends JpaRepository<Carrello, Long> {
    Optional<Carrello> findByUtente(Utente utente);
    Optional<Carrello> findByUtenteEmail(String email);
}
