// Copyright (c) 2016-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import FBSDKShareKit

public struct BridgingFailedError<Content: ContentProtocol>: Error {
  let nativeResults: [AnyHashable: Any]?
}

public class SDKSharingDelegateBridge<Content: ContentProtocol>: NSObject, SharingDelegate {
  public func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
    let dictionary = results.map {
      $0.keyValueFlatMap { key, value in
        (key as? String, value as? String)
      }
    }
    let sharingResult = dictionary.map(Content.Result.init)
    let result: ContentSharerResult<Content> = sharingResult.map(ContentSharerResult.success) ??
      .failed(BridgingFailedError<Content>(nativeResults: results))
    
    completion?(result)
  }
  
  public func sharer(_ sharer: Sharing, didFailWithError error: Error) {
    let error: Error = ShareError(error: (error as NSError)) as Error? ?? error
    completion?(.failed(error))
  }
  
  public func sharerDidCancel(_ sharer: Sharing) {
    completion?(.cancelled)
  }
  
  public var completion: ((ContentSharerResult<Content>) -> Void)?

  public func setupAsDelegateFor(_ sharer: Sharing) {
    // We need for the connection to retain us,
    // so we can stick around and keep calling into handlers,
    // as long as the connection is alive/sending messages.
    objc_setAssociatedObject(sharer, Unmanaged.passUnretained(self).toOpaque(), self, .OBJC_ASSOCIATION_RETAIN)
    sharer.delegate = self
  }

  
}
