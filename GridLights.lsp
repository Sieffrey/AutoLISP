;;;;;;;[   Block Placements   ];;;;;;;;;;;;;;;;;;;
;;                                              ;;
;;  To help with placements of blocks in a grid ;;
;;  like manner spaces. Useful for light        ;;
;;  placements in spaces                        ;;
;;                                              ;;
;;::::::::::::::::::::::::::::::::::::::::::::::;;
;;                                              ;;
;;  Author: Geoffrey Asare (Copyright 2017)     ;;
;;  Written: 11/28/2016                         ;;
;;                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                              ;;
;; This is actually my first contribution in    ;;
;; Github. I have been using this LISP function ;;
;; at office and it has really helped me with my;;
;; work flow. I hope people who use AutoCAD will;;
;; find this very useful.                       ;;
;;                                              ;;
;; PS. For some reason the placements of the    ;;
;; blocks are not accurate in some drwings when ;;
;; picking points the <OSnap> toggle is on so   ;;
;; if you encounter that please turn the        ;;
;; <Osnap> toggle off.                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun c:GridLight (/ LitBlock BasePt)
  (princ "\nSelect desired block")(princ)
  (setq LitBlock(ssget))
  (setq BasePt(getpoint "\nSelect the basepoint of the block"))
  (command "_copybase" BasePt LitBlock "")
  (princ "\nSelect starting point of the room: ")(princ)
  (setq pt1 (getpoint))
  (princ "\nSelect lenght of the room: ")(princ)
  (setq pt2 (getpoint))
  (setq pt3 (getpoint "\nSelect width of the room: "))
  (princ "\nEnter number of luminaries lengthwise: ")(princ)
  (setq nL (getreal))
  (princ "\nEnter number of luminaries widthwise: ")(princ)
  (setq nW (getreal))
  (setq AngRad (angle pt1 pt2))
  (setq PtDist (distance pt1 pt2))
  (setq AngRad2 (angle pt2 pt3))
  (setq PtDist2 (distance pt2 pt3))
  (setq LS1 (/ PtDist nL))
  (setq HLS1 (/ LS1 2.0))
  (setq LS2 (/ PtDist2 nW))
  (setq HLS2 (/ Ls2 2.0))

  
  (setq LitPt (polar pt1 AngRad HLS1))
  (setq LitPosW 1.0)
  (setq LitPosL 1.0)
  (setq LitPt2 (polar LitPt AngRad2 HLS2))
  (command "_pasteclip" LitPt2)
  (while (< LitPosL nL)
  (setq NextPt2 (polar LitPt2 AngRad (* LitPosL LS1)))
  (command "_pasteclip" NextPt2)
  (setq LitPosL (1+ LitPosL))
  )
  (setq LitPosL 1.0)
  (while (< LitPosW nW)
    (setq NextPt1 (polar LitPt2 AngRad2 (* LitPosW LS2)))
    (command "_pasteclip" NextPt1)
    (while (< LitPosL nL)
      (setq NextPt2 (polar NextPt1 AngRad (* LitPosL LS1)))
      (command "_pasteclip" NextPt2)
      (setq LitPosL (1+ LitPosL))
      )
    (setq LitPosL 1.0)
    (setq LitPosW (1+ LitPosW))
    )
  )