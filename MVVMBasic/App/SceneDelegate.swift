import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let nav = UINavigationController(rootViewController: OnboardingViewController())
        
        ////////////////////////////////
        let tabBarController = UITabBarController()
        // 나이탭
        let ageVC = AgeViewController()
        ageVC.tabBarItem = UITabBarItem(title: "나이", image: UIImage(systemName: "person.fill"), tag: 0)
        // 베엠아이 탭
        let bmiVC = BMIViewController()
        bmiVC.tabBarItem = UITabBarItem(title: "BMI", image: UIImage(systemName: "waveform.path.ecg"), tag: 1)
        // 생년월일 탭
        let birthDayVC = BirthDayViewController()
        birthDayVC.tabBarItem = UITabBarItem(title: "생년월일", image: UIImage(systemName: "calendar"), tag: 2)
        
        let wordCounterVC = WordCounterViewController()
        wordCounterVC.tabBarItem = UITabBarItem(title: "문자카운트", image: UIImage(systemName: "pencil.tip.crop.circle"), tag: 3)
        
        let currencyVC = CurrencyViewController()
        currencyVC.tabBarItem = UITabBarItem(title: "환율", image: UIImage(systemName: "sterlingsign.arrow.trianglehead.counterclockwise.rotate.90"), tag: 4)
        
        tabBarController.viewControllers = [ageVC, bmiVC, birthDayVC, wordCounterVC, currencyVC]
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        
//        window?.rootViewController = nav
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController() {
        let tabBarController = UITabBarController()
        // 나이탭
        let ageVC = AgeViewController()
        ageVC.tabBarItem = UITabBarItem(title: "나이", image: UIImage(systemName: "person.fill"), tag: 0)
        // 베엠아이 탭
        let bmiVC = BMIViewController()
        bmiVC.tabBarItem = UITabBarItem(title: "BMI", image: UIImage(systemName: "waveform.path.ecg"), tag: 1)
        // 생년월일 탭
        let birthDayVC = BirthDayViewController()
        birthDayVC.tabBarItem = UITabBarItem(title: "생년월일", image: UIImage(systemName: "calendar"), tag: 2)
        
        let wordCounterVC = WordCounterViewController()
        wordCounterVC.tabBarItem = UITabBarItem(title: "문자카운트", image: UIImage(systemName: "pencil.tip.crop.circle"), tag: 3)
        
        let currencyVC = CurrencyViewController()
        currencyVC.tabBarItem = UITabBarItem(title: "환율", image: UIImage(systemName: "sterlingsign.arrow.trianglehead.counterclockwise.rotate.90"), tag: 4)
        
        tabBarController.viewControllers = [ageVC, bmiVC, birthDayVC, wordCounterVC, currencyVC]
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.unselectedItemTintColor = .systemGray
        
        guard let window = self.window else { return }
                
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            window.rootViewController = tabBarController
        },
                          completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

