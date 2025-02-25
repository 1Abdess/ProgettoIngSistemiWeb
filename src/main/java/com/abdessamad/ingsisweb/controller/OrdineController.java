package com.abdessamad.ingsisweb.controller;

import com.abdessamad.ingsisweb.model.*;
import com.abdessamad.ingsisweb.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.security.Principal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/ordine")
public class OrdineController {
    @Autowired
    private OrdineRepository ordineRepository;

    @Autowired
    private UtenteRepository utenteRepository;

    @Autowired
    private CarrelloRepository carrelloRepository;

    @Autowired
    private ArticoloCarrelloRepository articoloCarrelloRepository;

    @Autowired
    private TracciamentoOrdineRepository tracciamentoOrdineRepository;

    @Autowired
    private CouponOrdineRepository couponOrdineRepository;

    // ========================== Salvataggio dell'Ordine ==========================
    @Transactional
    @PostMapping("/salva")
    public String salvaOrdine(@RequestParam("indirizzoSpedizione") String indirizzoSpedizione,
                              @RequestParam("metodoPagamento") String metodoPagamento,
                              Principal principal) {
        String email = principal.getName();
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(email);

        if (optionalUtente.isEmpty()) {
            return "redirect:/errore";
        }

        Utente utente = optionalUtente.get();
        Optional<Carrello> optionalCarrello = carrelloRepository.findByUtente(utente);

        if (optionalCarrello.isEmpty()) {
            return "redirect:/errore";
        }

        Carrello carrello = optionalCarrello.get();
        List<ArticoloCarrello> articoliCarrello = carrello.getArticoli();

        if (articoliCarrello.isEmpty()) {
            return "redirect:/errore";
        }

        // Creazione dell'ordine
        Ordine nuovoOrdine = new Ordine();
        nuovoOrdine.setUtente(utente);
        nuovoOrdine.setIndirizzoSpedizione(indirizzoSpedizione);
        nuovoOrdine.setStatoOrdine("In elaborazione");
        nuovoOrdine.setDataCreazione(new Timestamp(System.currentTimeMillis()));

        // Calcolo del totale
        BigDecimal totaleCarrello = articoliCarrello.stream()
                .map(articolo -> articolo.getProdotto().getPrezzo().multiply(BigDecimal.valueOf(articolo.getQuantita())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal totaleSconto = totaleCarrello;
        List<CouponOrdine> couponApplicati = carrello.getCouponApplicati();
        for (CouponOrdine couponOrdine : couponApplicati) {
            Coupon coupon = couponOrdine.getCoupon();
            BigDecimal percentualeSconto = BigDecimal.valueOf(coupon.getPercentualeSconto()).divide(BigDecimal.valueOf(100));
            BigDecimal importoSconto = totaleCarrello.multiply(percentualeSconto);
            totaleSconto = totaleSconto.subtract(importoSconto);
        }

        nuovoOrdine.setTotale(totaleSconto);

        // Salva gli articoli dell'ordine
        for (ArticoloCarrello articoloCarrello : articoliCarrello) {
            ArticoloOrdine articoloOrdine = new ArticoloOrdine();
            articoloOrdine.setOrdine(nuovoOrdine);
            articoloOrdine.setProdotto(articoloCarrello.getProdotto());
            articoloOrdine.setQuantita(articoloCarrello.getQuantita());
            articoloOrdine.setPrezzo(articoloCarrello.getProdotto().getPrezzo());
            nuovoOrdine.getArticoli().add(articoloOrdine);
        }

        ordineRepository.save(nuovoOrdine);

        // Tracciamento dell'ordine
        TracciamentoOrdine tracciamento = new TracciamentoOrdine();
        tracciamento.setOrdine(nuovoOrdine);
        tracciamento.setStato("Ordine Confermato");
        tracciamento.setDataAggiornamento(new Timestamp(System.currentTimeMillis()));
        tracciamentoOrdineRepository.save(tracciamento);

        // Pulizia del carrello
        articoloCarrelloRepository.deleteAllByCarrello(carrello);
        carrelloRepository.delete(carrello);

        return "redirect:/ordine/storico";
    }

    // ========================== Visualizzazione Storico Ordini ==========================
    @GetMapping("/storico")
    public String storicoOrdini(Model model, Principal principal) {
        String email = principal.getName();
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(email);

        if (optionalUtente.isPresent()) {
            Utente utente = optionalUtente.get();
            List<Ordine> ordini = ordineRepository.findByUtente(utente);
            model.addAttribute("ordini", ordini);
            return "storicoOrdini";
        }

        return "redirect:/errore";
    }
}
