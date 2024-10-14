package com.abdessamad.ingsisweb.controller;

import com.abdessamad.ingsisweb.model.Utente;
import com.abdessamad.ingsisweb.model.Prodotto;
import com.abdessamad.ingsisweb.model.Ordine;
import com.abdessamad.ingsisweb.repository.UtenteRepository;
import com.abdessamad.ingsisweb.repository.ProdottoRepository;
import com.abdessamad.ingsisweb.repository.OrdineRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private UtenteRepository utenteRepository;

    @Autowired
    private ProdottoRepository prodottoRepository;

    @Autowired
    private OrdineRepository ordineRepository;

    // ========================== Admin Dashboard ==========================
    // Punto d'ingresso alla dashboard amministrativa
    @GetMapping("/")
    public String adminDashboard(Model model) {
        return "admin/dashboard";
    }

    // ========================== Gestione Utenti ==========================
    // Visualizzazione degli utenti
    @GetMapping("/utenti")
    public String visualizzaUtenti(Model model) {
        model.addAttribute("utenti", utenteRepository.findAll());
        return "admin/utenti";
    }

    // Blocco/Sblocco di un utente
    @PostMapping("/utenti/blocco")
    public String bloccaSbloccaUtente(@RequestParam("email") String email, @RequestParam("azione") String azione) {
        Optional<Utente> optionalUtente = utenteRepository.findById(email);
        if (optionalUtente.isPresent()) {
            Utente utente = optionalUtente.get();
            utente.setBloccato("blocca".equals(azione));
            utenteRepository.save(utente);
        }
        return "redirect:/admin/utenti";
    }

    // Visualizzazione degli ordini di un singolo utente
    @GetMapping("/utenti/ordini")
    public String visualizzaOrdiniPerUtente(@RequestParam("email") String email, Model model) {
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(email);
        if (optionalUtente.isEmpty()) {
            return "admin/errore";
        }

        Utente utente = optionalUtente.get();
        List<Ordine> ordini = ordineRepository.findByUtente(utente);
        model.addAttribute("ordini", ordini);
        return "admin/ordiniUtente";
    }

    // Modifica del ruolo di un utente
    @PostMapping("/utenti/ruolo")
    public String cambiaRuoloUtente(@RequestParam("email") String email, @RequestParam("ruolo") String ruolo) {
        Optional<Utente> optionalUtente = utenteRepository.findById(email);
        if (optionalUtente.isPresent()) {
            Utente utente = optionalUtente.get();
            utente.setRuolo(ruolo);
            utenteRepository.save(utente);
        }
        return "redirect:/admin/utenti";
    }

    // ========================== Gestione Catalogo ==========================
    // Visualizzazione dei prodotti nel catalogo
    @GetMapping("/catalogo/prodotti")
    public String visualizzaProdotti(Model model) {
        List<Prodotto> prodotti = prodottoRepository.findAll();
        model.addAttribute("prodotti", prodotti);
        return "admin/prodotti";
    }

    // Form per aggiungere un nuovo prodotto
    @GetMapping("/catalogo/prodotti/nuovo")
    public String nuovoProdotto(Model model) {
        model.addAttribute("prodotto", new Prodotto());
        return "admin/nuovoProdotto";
    }

    // Salvataggio di un nuovo prodotto
    @PostMapping("/catalogo/prodotti/salva")
    public String salvaProdotto(@ModelAttribute Prodotto prodotto) {
        prodottoRepository.save(prodotto);
        return "redirect:/admin/catalogo/prodotti";
    }

    // Modifica di un prodotto esistente
    @GetMapping("/catalogo/prodotti/modifica/{id}")
    public String modificaProdotto(@PathVariable("id") int id, Model model) {
        Optional<Prodotto> optionalProdotto = prodottoRepository.findById(id);
        if (optionalProdotto.isPresent()) {
            model.addAttribute("prodotto", optionalProdotto.get());
            return "admin/nuovoProdotto";  // Stessa pagina JSP per inserimento e modifica
        }
        return "/errore";
    }

    // Blocco/Sblocco di un prodotto
    @PostMapping("/catalogo/prodotti/blocco")
    public String bloccaSbloccaProdotto(@RequestParam("id") int id, @RequestParam("azione") String azione) {
        Optional<Prodotto> optionalProdotto = prodottoRepository.findById(id);
        if (optionalProdotto.isPresent()) {
            Prodotto prodotto = optionalProdotto.get();
            prodotto.setBloccato("blocca".equals(azione));
            prodottoRepository.save(prodotto);
        }
        return "redirect:/admin/catalogo/prodotti";
    }

    // ========================== Gestione Ordini ==========================
    // Visualizzazione di tutti gli ordini
    @GetMapping("/ordini")
    public String visualizzaTuttiGliOrdini(Model model) {
        List<Ordine> ordini = ordineRepository.findAll();
        model.addAttribute("ordini", ordini);
        return "admin/tuttiOrdini";
    }

    // Visualizzazione dei dettagli di un singolo ordine
    @Transactional
    @GetMapping("/ordini/dettagli/{id}")
    public String visualizzaDettagliOrdine(@PathVariable("id") Long id, Model model) {
        Optional<Ordine> optionalOrdine = ordineRepository.findById(id);
        if (optionalOrdine.isPresent()) {
            Ordine ordine = optionalOrdine.get();
            model.addAttribute("ordine", ordine);
            model.addAttribute("articoli", ordine.getArticoli());
            return "admin/dettagliOrdine";
        }

        return "/errore";
    }

}
