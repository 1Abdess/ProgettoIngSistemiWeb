package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.Prodotto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProdottoRepository extends JpaRepository<Prodotto, Integer> {

    // Recupera i prodotti in promozione
    List<Prodotto> findByInPromozioneTrue();

    // Recupera tutte le categorie uniche
    @Query("SELECT DISTINCT p.categoria FROM Prodotto p")
    List<String> findAllCategorie();

    // Recupera tutti i marchi unici
    @Query("SELECT DISTINCT p.marchio FROM Prodotto p")
    List<String> findAllMarchi();

    @Query("SELECT p FROM Prodotto p WHERE " +
            "(:categoria IS NULL OR :categoria = '' OR p.categoria LIKE %:categoria%) AND " +
            "(:marchio IS NULL OR :marchio = '' OR p.marchio LIKE %:marchio%) AND " +
            "(:ricerca IS NULL OR :ricerca = '' OR p.nome LIKE %:ricerca%)")
    List<Prodotto> findFiltered(@Param("categoria") String categoria,
                                @Param("marchio") String marchio,
                                @Param("ricerca") String ricerca);
}
