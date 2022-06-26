//
//  MovieTimeViewController.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 15/02/2022.
//

import UIKit

class MovieTimeViewController: UIViewController {

    // View
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewDayTimeSlot: UICollectionView!
    
    @IBOutlet weak var viewForCornerRadius: UIView!
    // Constraints
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewCinemaDayTimeSlot: NSLayoutConstraint!
    
    var movieID = 0
    var cinemaID = 0
    let myCheckOut = MyCheckOut.shared
    var dates = [MyDate]()
    var selectedDate = ""
    var availableCinema = ""
    var cinemaTime = ""
    var selectedCinemaDayTimeslotId = 0
    var cinemas = [CinemaObject]()
    var cinemaDayTimeSlots : [CinemaDayTimeSlotObject]?
    let cinemaModel : CinemaModel = CinemaModelImpl.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        viewForCornerRadius.layer.cornerRadius = 15
        viewForCornerRadius.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        registerCells()
        setUpDataSourceAndDelegates()
        setUpHeightForCollectionView()
        getDates()
        getCinemaDayTimeSlot()
        getCinema()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        self.collectionViewDays.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [.centeredVertically])
        self.collectionView(collectionViewDays, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
    
    private func getDates() {
        dates = MyDate.comingNextDat()
        selectedDate = dates.first?.date ?? ""
        collectionViewDays.reloadData()
        
    }
    
    fileprivate func getCinema() {
        cinemaModel.getCinema { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cinemas = data
                if self.cinemas.count > 0 {
                    self.cinemaID = self.cinemas.first!.id!
                }
                self.collectionViewAvailableIn.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    fileprivate func getCinemaDayTimeSlot() {
        cinemaModel.getCinemaDayTimeSlot(id: myCheckOut._movieID, date: selectedDate ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cinemaDayTimeSlots = data
                self.setUpHeightForCollectionView()
                self.collectionViewDayTimeSlot.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    fileprivate func registerCells() {
        collectionViewDays.register(UINib(nibName: String(describing: DaysCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DaysCollectionViewCell.self))
        collectionViewAvailableIn.register(UINib(nibName: String(describing: TimeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TimeCollectionViewCell.self))
        collectionViewDayTimeSlot.register(UINib(nibName: String(describing: TimeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TimeCollectionViewCell.self))
    }
    
    fileprivate func setUpDataSourceAndDelegates() {
        
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewDayTimeSlot.dataSource = self
        collectionViewDayTimeSlot.delegate = self
    }
    
    fileprivate func setUpHeightForCollectionView() {
        collectionViewHeightAvailableIn.constant = 66
        collectionViewCinemaDayTimeSlot.constant = CGFloat((66+65) * (cinemaDayTimeSlots?.count ?? 0))
        self.view.layoutIfNeeded()
    }
    


    @IBAction func btnNextClicked(_ sender: UIButton) {
        if !availableCinema.isEmpty && selectedCinemaDayTimeslotId != 0 {
            myCheckOut._cinemaDayTimeslotID = selectedCinemaDayTimeslotId
            myCheckOut._bookingDate = selectedDate
            myCheckOut._cinemaName = availableCinema
            myCheckOut._cinemaTime = cinemaTime
            myCheckOut._cinemaID = cinemaID
            navigateToMovieSeatViewController()
        }
    }
    
    private func didSelectedDate(for myDate: MyDate) {
        selectedDate = myDate.date
        getCinemaDayTimeSlot()
    }
    
}

extension MovieTimeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          if (collectionView == collectionViewDayTimeSlot) {
              return cinemaDayTimeSlots?.count ?? 0
          }
          return 1
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDays {
            return dates.count
        }else if collectionView == collectionViewAvailableIn {
            return cinemas.count
        }else {
            if cinemaDayTimeSlots?.count ?? 0 > 0 {
                return cinemaDayTimeSlots?[section].timeslots.count ?? 0
            }else {
                return 0
                
            }
                     
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewDays {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DaysCollectionViewCell.self), for: indexPath) as? DaysCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = dates[indexPath.row]
            return cell
        }else if collectionView == collectionViewAvailableIn {
            guard let cell = collectionView.dequeueCell(identifier: String(describing: TimeCollectionViewCell.self) , indexPath: indexPath) as? TimeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cinemaData = cinemas[indexPath.row]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeCollectionViewCell.self), for: indexPath) as? TimeCollectionViewCell else {
                return UICollectionViewCell()
            }
            let time = cinemaDayTimeSlots?[indexPath.section].timeslots[indexPath.row]
            cell.timeSlot = time
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          switch kind {
          case UICollectionView.elementKindSectionHeader:
              let headerView = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: String(describing: CinemaDayTimeSlotHeader.self),
                  for: indexPath
              ) as! CinemaDayTimeSlotHeader
              headerView.cinemaNameLabel.text = cinemaDayTimeSlots?[indexPath.section].cinema
              
              return headerView
          default:
              assert(false, "Invalid element kind")
          }
      }
      
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewDays) {
            didSelectedDate(for: dates[indexPath.row])
        } else if (collectionView == collectionViewDayTimeSlot) {
            selectedCinemaDayTimeslotId = cinemaDayTimeSlots?[indexPath.section].timeslots[indexPath.row].cinemaDayTimeslotID! ?? 0
            cinemaTime = cinemaDayTimeSlots?[indexPath.section].timeslots[indexPath.row].startTime ?? ""
        } else {
            availableCinema = cinemas[indexPath.row].name ?? ""
            cinemaID = cinemas[indexPath.row].id!
        }
    }
    
}

extension MovieTimeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewDays {
            return CGSize(width: 60, height: 80)
        }else {
            let width = collectionView.bounds.width / 3
            let height = CGFloat(66)
            return CGSize(width: width, height: height)
        }
    }
    
}
