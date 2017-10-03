//
//  RSFloatInputViewUtils
//  ThirdParty
//
//  Created by ThirdParty on 02/08/17.
//  Copyright © 2017 ThirdParty. All rights reserved.
//

import UIKit

extension UIView {
  var ending: CGPoint { return CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height) }
  var viewWidth: CGFloat { return frame.width }
  var viewHeight: CGFloat { return frame.height - 18 }
}

extension CGFloat {
  var half: CGFloat { return self / 2 }
  var double: CGFloat { return self * 2 }
}
