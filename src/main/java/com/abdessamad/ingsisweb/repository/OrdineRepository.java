package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Ordine;
import com.abdessamad.ingsisweb.model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrdineRepository extends JpaRepository<Ordine, Long> {
    List<Ordine> findByUtenteEmail(String email);

    List<Ordine> findByUtente(Utente utente);
}
