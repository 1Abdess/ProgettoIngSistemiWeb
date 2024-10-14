package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.ArticoloOrdine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticoloOrdineRepository extends JpaRepository<ArticoloOrdine, Integer> {
}
