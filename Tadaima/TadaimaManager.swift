import MultipeerConnectivity
import UIKit

typealias stateChange = ((state: MCSessionState) -> ())?

class TadaimaManager: NSObject, MCNearbyServiceBrowserDelegate, MCSessionDelegate {
    let localPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    let browser: MCNearbyServiceBrowser?
    var session: MCSession?
    var onStateChange: stateChange?
    var tadaimaUserName = "dav" // TODO : should be set from the interface
    
    override init() {
        super.init()
        browser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: "tadaima")
        browser!.delegate = self
        browser!.startBrowsingForPeers()
        println("MC: Started browsing with \(browser)")
    }
}

// MARK: MCNearbyServiceBrowserDelegate

extension TadaimaManager {
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        println("MC: foundPeer \(peerID) with discovery info \(info)")

        session = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .None)
        session!.delegate = self
        println("MC: created session and inviting \(session)")
        let userNameData = tadaimaUserName.dataUsingEncoding(NSUTF8StringEncoding)
        browser!.invitePeer(peerID, toSession: session, withContext: userNameData, timeout: 0)
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        println("MC: nearby peer lost: \(peerID)")
    }
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        println("MC: Browsing did not start due to error: \(error)")
    }
}

// MARK: MCSessionDelegate

extension TadaimaManager {
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        println("MC: Session \(session) changed state to \(state.rawValue)")
        if let block = onStateChange? {
            block(state: state)
        }
        
        // We don't actually need to use the session to send any data. The only thing that matters
        // is that the invitation contains the userName. However we need a session to make
        // the invitation.
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
    }
    
}