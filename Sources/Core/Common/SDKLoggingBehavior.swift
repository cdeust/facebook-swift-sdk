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

import FBSDKCoreKit.FBSDKSettings

/**
 Defines logging behavior used by the SDK.
 To set/enable/disable specific behaviors use `Settings.loggingBehaviors`.
 */
public enum SDKLoggingBehavior {
  /// Include access token in logging.
  case accessTokens

  /// Log performance characteristics
  case performanceCharacteristics

  /// Log `AppEventsLogger` interactions.
  case appEvents

  /// Log informational occurences.
  case informational

  /// Log cache errors.
  case cacheErrors

  /// Log errors from SDK UI controls.
  case uiControlErrors

  /// Log debug warnings from API responses, e.g. when friends fields were requested,
  /// but `user_friends` permissions isn't granted.
  case graphAPIDebugWarning

  /**
   Log warnings from API responses, e.g. when requested feature will be deprecated in next version of API.
   Info is the lowest level of severity, using it will result in logging all previously mentioned levels.
   */
  case graphAPIDebugInfo

  /// Log errors from SDK network requests.
  case networkRequests

  /// Log errors likely to be preventable by the developer. This behavior is enabled by default.
  case developerErrors

  internal init?(sdkStringValue: String) {
    switch sdkStringValue {
    case LoggingBehavior.accessTokens.rawValue: self = .accessTokens
    case LoggingBehavior.performanceCharacteristics.rawValue: self = .performanceCharacteristics
    case LoggingBehavior.appEvents.rawValue: self = .appEvents
    case LoggingBehavior.informational.rawValue: self = .informational
    case LoggingBehavior.cacheErrors.rawValue: self = .cacheErrors
    case LoggingBehavior.uiControlErrors.rawValue: self = .uiControlErrors
    case LoggingBehavior.graphAPIDebugWarning.rawValue: self = .graphAPIDebugWarning
    case LoggingBehavior.graphAPIDebugInfo.rawValue: self = .graphAPIDebugInfo
    case LoggingBehavior.networkRequests.rawValue: self = .networkRequests
    case LoggingBehavior.developerErrors.rawValue: self = .developerErrors
    default: return nil
    }
  }

  internal var sdkStringValue: String {
    switch self {
    case .accessTokens: return LoggingBehavior.accessTokens.rawValue
    case .performanceCharacteristics: return LoggingBehavior.performanceCharacteristics.rawValue
    case .appEvents: return LoggingBehavior.appEvents.rawValue
    case .informational: return LoggingBehavior.informational.rawValue
    case .cacheErrors: return LoggingBehavior.cacheErrors.rawValue
    case .uiControlErrors: return LoggingBehavior.uiControlErrors.rawValue
    case .graphAPIDebugWarning: return LoggingBehavior.graphAPIDebugWarning.rawValue
    case .graphAPIDebugInfo: return LoggingBehavior.graphAPIDebugInfo.rawValue
    case .networkRequests: return LoggingBehavior.networkRequests.rawValue
    case .developerErrors: return LoggingBehavior.developerErrors.rawValue
    }
  }
}
