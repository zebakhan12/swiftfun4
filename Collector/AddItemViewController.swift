//
//  AddItemViewController.swift
//  Collector
//
//  Created by Zeba Khan on 5/3/18.
//  Copyright © 2018 Zeba Khan. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //code allowing the display of photo that was picked
        imagePicker.delegate = self
    }
    // code for pulling up photos from your photo library
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    // code for taking photos on camera
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    //code allowwing user to select photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = choosenImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // this piece of code below will allow us to push data (photo and title that user will enter into app)to core data so we can save it. This is why we need to first add the entity, then write code for the elements inside our entity which is Title and Image. Now that we have passed Title and Image to Core Data, we want to save it and then push user back to the main screen. Once on the main screen, we need to write more code for the user to be able to access the photo and title that was added.
  
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextField.text
            
            if let image = itemImageView.image {
                if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData
                }
            }
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
    }
}
