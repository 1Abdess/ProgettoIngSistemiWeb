package com.abdessamad.ingsisweb.service;

import com.abdessamad.ingsisweb.repository.ArticoloCarrelloRepository;
import com.abdessamad.ingsisweb.repository.CarrelloRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarrelloService {

    @Autowired
    private ArticoloCarrelloRepository articoloCarrelloRepository;

    @Autowired
    private CarrelloRepository carrelloRepository;

    @Transactional
    public void eliminaCarrello(Long carrelloId) {
        // Prima elimina tutti gli articoli associati al carrello
        articoloCarrelloRepository.deleteByCarrelloId(carrelloId);

        // Poi elimina il carrello
        carrelloRepository.deleteById(carrelloId);
    }
}
