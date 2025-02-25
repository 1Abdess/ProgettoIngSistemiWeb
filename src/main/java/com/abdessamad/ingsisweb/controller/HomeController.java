package com.abdessamad.ingsisweb.controller;

import com.abdessamad.ingsisweb.model.Prodotto;
import com.abdessamad.ingsisweb.model.Utente;
import com.abdessamad.ingsisweb.repository.ProdottoRepository;
import com.abdessamad.ingsisweb.repository.UtenteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
public class HomeController {

    @Autowired
    private ProdottoRepository prodottoRepository;

    @Autowired
    private UtenteRepository utenteRepository;

    @GetMapping("/")
    public String homePage(Model model,
                           @RequestParam(required = false) String categoria,
                           @RequestParam(required = false) String marchio,
                           @RequestParam(required = false) String ricerca,
                           Principal principal) {

        if (principal != null) {
            // Recupera l'utente autenticato
            Optional<Utente> optionalUtente = utenteRepository.findByEmail(principal.getName());

            // Verifica se l'utente esiste e se è bloccato
            if (optionalUtente.isPresent()) {
                Utente utente = optionalUtente.get();
                if (utente.isBloccato()) {
                    model.addAttribute("utenteBloccato", true);
                    return "home"; // L'utente è bloccato, carica la home con il messaggio di blocco
                }

                // Aggiungi il ruolo dell'utente al modello
                model.addAttribute("ruoloUtente", utente.getRuolo());
            }
        }

        // Recupera i prodotti in promozione
        List<Prodotto> prodottiPromo = prodottoRepository.findByInPromozioneTrue();
        model.addAttribute("prodottiPromo", prodottiPromo);

        // Recupera tutte le categorie e marchi unici
        List<String> categorie = prodottoRepository.findAllCategorie();
        List<String> marchi = prodottoRepository.findAllMarchi();
        model.addAttribute("categorie", categorie);
        model.addAttribute("marchi", marchi);

        // Filtra i prodotti per categoria, marchio o ricerca libera
        List<Prodotto> prodotti = prodottoRepository.findFiltered(categoria, marchio, ricerca);
        model.addAttribute("prodotti", prodotti);

        return "home"; // Carica la pagina della home
    }

}
