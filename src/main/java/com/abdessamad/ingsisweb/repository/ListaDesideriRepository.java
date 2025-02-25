package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.ListaDesideri;
import com.abdessamad.ingsisweb.model.Utente;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ListaDesideriRepository extends JpaRepository<ListaDesideri, Integer> {
    List<ListaDesideri> findByUtente(Utente utente);
}
