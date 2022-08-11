//
//  AppDelegate.swift
//  sBrain
//
//  Created by Fábio Silva  on 07/08/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "dadosGuardados"), let dataC = UserDefaults.standard.data(forKey: "dadosGuardadosC") {
            do {
                let arr = try JSONDecoder().decode([Tarefa].self, from: data)
                let arrC = try JSONDecoder().decode([Tarefa].self, from: dataC)
                Tarefa.tarefas = arr
                Tarefa.tarefasC = arrC
            } catch {
                print(error)
            }
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let guardarArrayC = Tarefa.tarefasC
        let guardarArray = Tarefa.tarefas
        do {
            let data = try JSONEncoder().encode(guardarArray)
            let dataC = try JSONEncoder().encode(guardarArrayC)
            UserDefaults.standard.set(data, forKey: "dadosGuardados")
            UserDefaults.standard.set(dataC, forKey: "dadosGuardadosC")
        } catch  {
            print(error)
        }
    }
}

