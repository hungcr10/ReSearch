import UIKit
//import Alamofire
//import CoreLocation
//import RxCocoa
//import RxSwift
//import RealmSwift
//import WeScan
//import SnapKit

class FirstLifecycleVC: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        print("loadview")
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        print("loadviewifneed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = UIImage(systemName: "terminal")
        view.backgroundColor = .systemGray
        print("ViewDidLoad")
        
    }
    // main thread , bgr thread
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("layoutsubview")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("didlayoutsubview")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    //MARK: - Action
    @IBAction func nextToSecondLifecycleVC(_ sender: Any) {
        self.performSegue(withIdentifier: "SecondView", sender: nil)
    }
}


