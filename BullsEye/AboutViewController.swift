//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Stephen Bassett on 8/10/18.
//  Copyright © 2018 Stephen Bassett. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    static var selectedPoints = 25
    static var selectedRounds = 10
    static var pointsSegmentIndex = 2
    static var roundsSegmentIndex = 2

    @IBOutlet weak var roundsSelected: UISegmentedControl!
    @IBOutlet weak var pointsLimitSelected: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundsSelected.selectedSegmentIndex = AboutViewController.roundsSegmentIndex
        pointsLimitSelected.selectedSegmentIndex = AboutViewController.pointsSegmentIndex
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func roundSegmetControl(_ sender: Any) {
        guard let value = Int(roundsSelected.titleForSegment(at: roundsSelected.selectedSegmentIndex) ?? "") else { return }
        AboutViewController.selectedRounds = value
        switch roundsSelected.selectedSegmentIndex {
        case 0,1,2,3,4,5:
//            ViewController.numberOfRounds = value
            AboutViewController.roundsSegmentIndex = roundsSelected.selectedSegmentIndex
            UserDefaults.standard.set(AboutViewController.roundsSegmentIndex, forKey: "numberOfRounds")
            UserDefaults.standard.synchronize()
        default:
            break
        }
    }
    
    @IBAction func pointSegmentControl(_ sender: Any) {
        guard let points = Int(pointsLimitSelected.titleForSegment(at: pointsLimitSelected.selectedSegmentIndex) ?? "") else { return }
        AboutViewController.selectedPoints = points
        switch pointsLimitSelected.selectedSegmentIndex {
        case 0,1,2,3,4,5:
//            ViewController.scoreToBeat = points
            AboutViewController.pointsSegmentIndex = pointsLimitSelected.selectedSegmentIndex
            UserDefaults.standard.set(AboutViewController.pointsSegmentIndex, forKey: "scoreToBeat")
            UserDefaults.standard.synchronize()
        default:
            break
        }
    }
    
}
