package com.abdessamad.ingsisweb.repository;

import com.abdessamad.ingsisweb.model.ArticoloCarrello;
import com.abdessamad.ingsisweb.model.Carrello;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticoloCarrelloRepository extends JpaRepository<ArticoloCarrello, Integer> {
    void deleteByCarrelloId(Long carrelloId);

    void deleteAllByCarrello(Carrello carrello);

}
