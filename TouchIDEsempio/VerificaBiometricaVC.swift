//
//  VerificaBiometricaVC.swift
//  TouchIDEsempio
//
//  Created by riccardo silvi on 22/03/18.
//  Copyright © 2018 riccardo silvi. All rights reserved.
//



import UIKit
//importiamo il framework necessario
import LocalAuthentication

class VerificaBiometricaVC: UIViewController {
    
    //label per dare un riscontro visivo della verifica
    @IBOutlet weak var lblRisultato: UILabel!
    
    //Alla fine del caricamento della view...
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificaTouchID()
        
    }
    
    func verificaTouchID() {
        
        //creiamo un istanza contesto di autenticazione per
        //la verifica touchID...
        
        let autorizzazioneContext = LAContext()
        
        //...e una var per gli errori eventualmente prodotti
        var errore:NSError?
        
        //solo se il dispositivo è in grado di effettuare una verifica con il TouchID
        if autorizzazioneContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &errore) {
            //sfruttiamo il metodo dedicato che esegue il controllo biometrico
            autorizzazioneContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Verifica Identità Utente", reply: {(success, error) in
                //gestione del risultato
                DispatchQueue.main.async {
                    if success {
                        self.lblRisultato.cambia(testo: "Risultato: Verificato", eBackground: .green)
    
                    } else {
                        self.lblRisultato.cambia(testo: "Risultato: Non verificato", eBackground: .red)
                    }
                }
            })
        } else {
            DispatchQueue.main.async {
                 self.lblRisultato.text = "Verifica TouchID non disponibile"
            }
        }
    }
    
    @IBAction func bottoneRiprovaPremuto(_ sender: UIButton) {
        
        self.lblRisultato.cambia(testo: "RIPROVIAMO!", eBackground: .yellow)
        
        verificaTouchID()
    }
    
}

