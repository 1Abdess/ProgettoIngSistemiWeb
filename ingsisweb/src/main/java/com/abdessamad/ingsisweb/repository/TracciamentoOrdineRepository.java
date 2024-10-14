package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Ordine;
import com.abdessamad.ingsisweb.model.TracciamentoOrdine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TracciamentoOrdineRepository extends JpaRepository<TracciamentoOrdine, Integer> {
    List<TracciamentoOrdine> findByOrdine(Ordine ordine);
}
