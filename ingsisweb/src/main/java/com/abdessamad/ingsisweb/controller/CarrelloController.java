package com.abdessamad.ingsisweb.controller;

import com.abdessamad.ingsisweb.model.*;
import com.abdessamad.ingsisweb.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.hibernate.Hibernate;

import java.math.BigDecimal;
import java.security.Principal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Controller
public class CarrelloController {
    @Autowired
    private UtenteRepository utenteRepository;

    @Autowired
    private CarrelloRepository carrelloRepository;

    @Autowired
    private ArticoloCarrelloRepository articoloCarrelloRepository;

    @Autowired
    private CouponRepository couponRepository;

    @Autowired
    private ListaDesideriRepository listaDesideriRepository;

    @Autowired
    private ProdottoRepository prodottoRepository;

    @Autowired
    private CouponOrdineRepository couponOrdineRepository;

    private BigDecimal totaleSconto = BigDecimal.ZERO; // Memorizza il valore del totale scontato

    // ========================== Visualizzazione Carrello ==========================
    @Transactional
    @GetMapping("/carrello")
    public String mostraCarrello(Model model, Principal principal) {
        String emailUtente = principal.getName();
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(emailUtente);

        if (optionalUtente.isEmpty()) {
            model.addAttribute("messaggioErrore", "Utente non trovato");
            return "errore";
        }

        Utente utente = optionalUtente.get();
        Carrello carrello = carrelloRepository.findByUtente(utente)
                .orElseGet(() -> {
                    Carrello nuovoCarrello = new Carrello();
                    nuovoCarrello.setUtente(utente);
                    nuovoCarrello.setDataCreazione(new Timestamp(System.currentTimeMillis()));
                    return carrelloRepository.save(nuovoCarrello);
                });

        Hibernate.initialize(carrello.getCouponApplicati());
        List<ArticoloCarrello> articoli = carrello.getArticoli();

        if (articoli.isEmpty()) {
            model.addAttribute("carrelloVuoto", true);
        } else {
            model.addAttribute("articoli", articoli);
            BigDecimal totaleCarrello = articoli.stream()
                    .map(articolo -> articolo.getProdotto().getPrezzo().multiply(BigDecimal.valueOf(articolo.getQuantita())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            model.addAttribute("totaleCarrello", totaleCarrello);

            List<CouponOrdine> couponApplicati = carrello.getCouponApplicati();
            BigDecimal totaleSconto = totaleCarrello;
            for (CouponOrdine couponOrdine : couponApplicati) {
                Coupon coupon = couponOrdine.getCoupon();
                totaleSconto = totaleSconto.subtract(totaleCarrello.multiply(BigDecimal.valueOf(coupon.getPercentualeSconto()).divide(BigDecimal.valueOf(100))));
            }
            model.addAttribute("totaleSconto", totaleSconto);
            model.addAttribute("couponApplicati", couponApplicati);
        }

        List<ListaDesideri> listaDesideri = listaDesideriRepository.findByUtente(utente);
        model.addAttribute("listaDesideri", listaDesideri);

        return "carrello";
    }

    // ========================== Gestione Coupon ==========================
    @PostMapping("/carrello/applicaCoupon")
    public String applicaCoupon(@RequestParam("codiceCoupon") String codiceCoupon, Principal principal, Model model) {
        Optional<Coupon> optionalCoupon = couponRepository.findByCodice(codiceCoupon);

        if (optionalCoupon.isEmpty() || !optionalCoupon.get().isAttivo() ||
                optionalCoupon.get().getValidoFinoA().before(new Date(System.currentTimeMillis()))) {
            model.addAttribute("messaggioErrore", "Il coupon non è valido o è scaduto.");
            return mostraCarrello(model, principal);
        }

        Coupon coupon = optionalCoupon.get();
        Utente utente = utenteRepository.findByEmail(principal.getName()).get();

        Carrello carrello = carrelloRepository.findByUtente(utente)
                .orElseGet(() -> {
                    Carrello nuovoCarrello = new Carrello();
                    nuovoCarrello.setUtente(utente);
                    nuovoCarrello.setDataCreazione(new Timestamp(System.currentTimeMillis()));
                    return carrelloRepository.save(nuovoCarrello);
                });

        boolean alreadyApplied = carrello.getCouponApplicati().stream()
                .anyMatch(c -> c.getCoupon().getId() == coupon.getId());

        if (!alreadyApplied) {
            CouponOrdine nuovoCouponOrdine = new CouponOrdine();
            nuovoCouponOrdine.setCarrello(carrello);
            nuovoCouponOrdine.setCoupon(coupon);
            couponOrdineRepository.save(nuovoCouponOrdine);
        }

        return "redirect:/carrello";
    }

    // Rimozione di un coupon
    @PostMapping("/carrello/rimuoviCoupon")
    public String rimuoviCoupon(@RequestParam("idCoupon") int idCoupon, Principal principal) {
        Utente utente = utenteRepository.findByEmail(principal.getName()).get();

        Carrello carrello = carrelloRepository.findByUtente(utente)
                .orElseGet(() -> {
                    Carrello nuovoCarrello = new Carrello();
                    nuovoCarrello.setUtente(utente);
                    nuovoCarrello.setDataCreazione(new Timestamp(System.currentTimeMillis()));
                    return carrelloRepository.save(nuovoCarrello);
                });

        Optional<CouponOrdine> optionalCouponOrdine = couponOrdineRepository
                .findByCarrelloAndCouponId(carrello, idCoupon);

        if (optionalCouponOrdine.isPresent()) {
            couponOrdineRepository.delete(optionalCouponOrdine.get());
        }

        return "redirect:/carrello";
    }

    // ========================== Aggiunta e Modifica Articoli nel Carrello ==========================
    @PostMapping("/carrello/aggiungi")
    public String aggiungiAlCarrello(@RequestParam("idProdotto") int idProdotto,
                                     @RequestParam("quantita") int quantita,
                                     Principal principal,
                                     Model model) {
        String emailUtente = principal.getName();
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(emailUtente);
        if (optionalUtente.isEmpty()) {
            return "redirect:/";
        }
        Utente utente = optionalUtente.get();

        Carrello carrello = carrelloRepository.findByUtente(utente)
                .orElseGet(() -> {
                    Carrello nuovoCarrello = new Carrello();
                    nuovoCarrello.setUtente(utente);
                    nuovoCarrello.setDataCreazione(new Timestamp(System.currentTimeMillis()));
                    return carrelloRepository.save(nuovoCarrello);
                });

        Optional<Prodotto> optionalProdotto = prodottoRepository.findById(idProdotto);
        if (optionalProdotto.isEmpty()) {
            return "redirect:/";
        }
        Prodotto prodotto = optionalProdotto.get();

        if (quantita > prodotto.getQuantitaMagazzino()) {
            model.addAttribute("messaggioErrore", "L'elemento " + prodotto.getNome() +
                    " supera la quantità disponibile di " + prodotto.getQuantitaMagazzino());
            return mostraCarrello(model, principal);
        }

        Optional<ArticoloCarrello> existingArticolo = carrello.getArticoli().stream()
                .filter(ac -> ac.getProdotto().getId() == prodotto.getId())
                .findFirst();

        if (existingArticolo.isPresent()) {
            ArticoloCarrello articolo = existingArticolo.get();
            articolo.setQuantita(articolo.getQuantita() + quantita);
            articoloCarrelloRepository.save(articolo);
        } else {
            ArticoloCarrello nuovoArticolo = new ArticoloCarrello();
            nuovoArticolo.setCarrello(carrello);
            nuovoArticolo.setProdotto(prodotto);
            nuovoArticolo.setQuantita(quantita);
            articoloCarrelloRepository.save(nuovoArticolo);
        }

        return "redirect:/carrello";
    }

    @PostMapping("/carrello/modificaQuantita")
    public String modificaQuantitaCarrello(@RequestParam("idArticolo") int idArticolo,
                                           @RequestParam("quantita") int quantita,
                                           Model model,
                                           Principal principal) {
        Optional<ArticoloCarrello> optionalArticolo = articoloCarrelloRepository.findById(idArticolo);
        if (optionalArticolo.isPresent()) {
            ArticoloCarrello articolo = optionalArticolo.get();
            Prodotto prodotto = articolo.getProdotto();

            if (quantita > prodotto.getQuantitaMagazzino()) {
                model.addAttribute("messaggioErrore", "L'elemento " + prodotto.getNome() +
                        " supera la quantità disponibile di " + prodotto.getQuantitaMagazzino());
                return mostraCarrello(model, principal);
            }

            if (quantita > 0) {
                articolo.setQuantita(quantita);
                articoloCarrelloRepository.save(articolo);
            } else {
                articoloCarrelloRepository.delete(articolo);
            }
        }
        return "redirect:/carrello";
    }

    @PostMapping("/carrello/rimuovi")
    public String rimuoviArticolo(@RequestParam("idArticolo") int idArticolo) {
        Optional<ArticoloCarrello> optionalArticolo = articoloCarrelloRepository.findById(idArticolo);
        if (optionalArticolo.isPresent()) {
            articoloCarrelloRepository.delete(optionalArticolo.get());
        }
        return "redirect:/carrello";
    }

    // ========================== Gestione Wishlist ==========================
    @PostMapping("/wishlist/aggiungi")
    public String aggiungiAllaWishlist(@RequestParam("idProdotto") int idProdotto, Principal principal) {
        String emailUtente = principal.getName();
        Optional<Utente> optionalUtente = utenteRepository.findByEmail(emailUtente);
        if (optionalUtente.isEmpty()) {
            return "redirect:/error";
        }

        Utente utente = optionalUtente.get();
        Optional<Prodotto> optionalProdotto = prodottoRepository.findById(idProdotto);
        if (optionalProdotto.isEmpty()) {
            return "redirect:/error";
        }

        Prodotto prodotto = optionalProdotto.get();
        List<ListaDesideri> listaDesideri = listaDesideriRepository.findByUtente(utente);
        boolean alreadyInWishlist = listaDesideri.stream()
                .anyMatch(ld -> ld.getProdotto().getId() == prodotto.getId());

        if (!alreadyInWishlist) {
            ListaDesideri nuovoDesiderio = new ListaDesideri();
            nuovoDesiderio.setUtente(utente);
            nuovoDesiderio.setProdotto(prodotto);
            nuovoDesiderio.setDataCreazione(new Timestamp(System.currentTimeMillis()));
            listaDesideriRepository.save(nuovoDesiderio);
        }

        return "redirect:/";
    }

    @PostMapping("/wishlist/aggiungiAlCarrello")
    public String aggiungiAlCarrelloDallaWishlist(@RequestParam("idWishlist") int idWishlist, Principal principal) {
        String emailUtente = principal.getName();

        Optional<Utente> optionalUtente = utenteRepository.findByEmail(emailUtente);
        if (optionalUtente.isEmpty()) {
            return "redirect:/carrello";
        }
        Utente utente = optionalUtente.get();

        Carrello carrello = carrelloRepository.findByUtente(utente)
                .orElseGet(() -> {
                    Carrello nuovoCarrello = new Carrello();
                    nuovoCarrello.setUtente(utente);
                    nuovoCarrello.setDataCreazione(new Timestamp(System.currentTimeMillis()));
                    return carrelloRepository.save(nuovoCarrello);
                });

        Optional<ListaDesideri> optionalWishlistItem = listaDesideriRepository.findById(idWishlist);
        if (optionalWishlistItem.isPresent()) {
            ListaDesideri wishlistItem = optionalWishlistItem.get();
            Prodotto prodotto = wishlistItem.getProdotto();

            Optional<ArticoloCarrello> existingArticolo = carrello.getArticoli().stream()
                    .filter(ac -> ac.getProdotto().getId() == prodotto.getId())
                    .findFirst();

            if (existingArticolo.isPresent()) {
                ArticoloCarrello articolo = existingArticolo.get();
                articolo.setQuantita(articolo.getQuantita() + 1);
                articoloCarrelloRepository.save(articolo);
            } else {
                ArticoloCarrello nuovoArticolo = new ArticoloCarrello();
                nuovoArticolo.setCarrello(carrello);
                nuovoArticolo.setProdotto(prodotto);
                nuovoArticolo.setQuantita(1);
                articoloCarrelloRepository.save(nuovoArticolo);
            }

            listaDesideriRepository.delete(wishlistItem);
        }

        return "redirect:/carrello";
    }

    @PostMapping("/wishlist/rimuovi")
    public String rimuoviDaWishlist(@RequestParam("idWishlist") int idWishlist) {
        Optional<ListaDesideri> optionalWishlistItem = listaDesideriRepository.findById(idWishlist);
        if (optionalWishlistItem.isPresent()) {
            listaDesideriRepository.delete(optionalWishlistItem.get());
        }
        return "redirect:/carrello";
    }
}
