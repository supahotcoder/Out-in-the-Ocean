//
//  BodyPaths.swift
//
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class BodyPathsBodySizes {
// trida se pouziva pro dostani spravne velikosti a fyzickeho tela pro sprite podle nazvu obrazku (textury)

    class func getBodySize(textureName: String) -> CGSize {
        //        vraci velikost pro dane jmeno textury
        switch textureName{
        case "wander":
            return CGSize(width: 120, height: 120)
        case "crystal-key":
            return CGSize(width: 45, height: 70)
        case "slime":
            return CGSize(width: 100, height: 100)
        case "big_talk":
            return CGSize(width: 200, height: 200)
        case "crystalio":
            return CGSize(width: 71.17, height: 110)
        case "evil_player1":
            return CGSize(width: 110, height: 110)
        case "donut":
            return CGSize(width: 60, height: 60)
        case "spin":
            return CGSize(width: 300, height: 300)
        case "player_test":
            return CGSize(width: 60, height: 60)
        case "boundaries1_2":
            return CGSize(width: 6000, height: 1500)
        case "minerals":
            return CGSize(width: 2592, height: 1620)
        case "plush":
            return CGSize(width: 114, height: 200)
        case "bigeyyy":
            return CGSize(width: 200, height: 200)
        case "diamantier":
            return CGSize(width: 160, height: 217)
        case "mudder":
            return CGSize(width: 180, height: 172)
        case "huh":
            return CGSize(width: 135, height: 150)
        case "cupcakeus":
            return CGSize(width: 90, height: 86)
        case "crowner":
            return CGSize(width: 180, height: 220)
        default:
            return CGSize(width: 150, height: 150)
        }
    }
    
    
    class func getPhysicsBodyOf(textureName: String, sprite: SKSpriteNode) -> SKPhysicsBody {
        //        vraci fyzicke telo pro dany sprite podle nazvu textury
        switch textureName{
        case "boundaries1_2":
            return boundaries1_2(sprite: sprite)
        case "wander":
            return wanderBody(sprite: sprite)
        case "crystal-key":
            return crystalKeyBody(sprite: sprite)
        case "minerals":
            return crystalLevelBody(sprite: sprite)
        case "slime":
            return slimeBody(sprite: sprite)
        case "crystalio":
            return crystalioBody(sprite: sprite)
        case "donut":
            return SKPhysicsBody(circleOfRadius: getBodySize(textureName: "donut").width / 2)
        case "spin":
            return SKPhysicsBody.init(circleOfRadius: 60)
        case "evil_player1":
            return SKPhysicsBody(circleOfRadius: getBodySize(textureName: "evil_player1").width / 2)
        case "plush":
            return plushBody(sprite: sprite)
        case "player_test":
            return SKPhysicsBody(circleOfRadius: getBodySize(textureName: "player_test").width / 2.1)
        case "big_talk":
            return SKPhysicsBody(circleOfRadius: sprite.size.width / 2.5)
        case "bigeyyy":
            return bigeyyyBody(sprite: sprite)
        case "diamantier":
            return diamantierBody(sprite: sprite)
        case "huh":
            return huhBody(sprite: sprite)
        case "crowner":
            return crownerBody(sprite: sprite)
        case "cupcakeus":
            return cupcakeusBody(sprite: sprite)
        case "mudder":
            return SKPhysicsBody(circleOfRadius: sprite.size.width / 2.7)
        default:
            return SKPhysicsBody(circleOfRadius: sprite.size.width / 1.5)
        }
    }

    private class func cupcakeusBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 4.5
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(196 / w) - offsetX, y: CGFloat(381 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(161 / w) - offsetX, y: CGFloat(337 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(109 / w) - offsetX, y: CGFloat(350 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(143 / w) - offsetX, y: CGFloat(327 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(117 / w) - offsetX, y: CGFloat(294 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(98 / w) - offsetX, y: CGFloat(145 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(20 / w) - offsetX, y: CGFloat(92 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(10 / w) - offsetX, y: CGFloat(76 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(58 / w) - offsetX, y: CGFloat(79 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(71 / w) - offsetX, y: CGFloat(32 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(144 / w) - offsetX, y: CGFloat(65 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(182 / w) - offsetX, y: CGFloat(54 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(199 / w) - offsetX, y: CGFloat(6 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(224 / w) - offsetX, y: CGFloat(50 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(260 / w) - offsetX, y: CGFloat(55 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(333 / w) - offsetX, y: CGFloat(26 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(295 / w) - offsetX, y: CGFloat(74 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(318 / w) - offsetX, y: CGFloat(93 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(397 / w) - offsetX, y: CGFloat(78 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(310 / w) - offsetX, y: CGFloat(144 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w) - offsetX, y: CGFloat(281 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(262 / w) - offsetX, y: CGFloat(327 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(286 / w) - offsetX, y: CGFloat(349 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(243 / w) - offsetX, y: CGFloat(338 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func crownerBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 2.35
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(167 / w) - offsetX,y: CGFloat(503 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(119 / w)  - offsetX,y: CGFloat(425 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(138 / w)  - offsetX,y: CGFloat(348 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(113 / w)  - offsetX,y: CGFloat(340 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(142 / w)  - offsetX,y: CGFloat(321 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(142 / w)  - offsetX,y: CGFloat(252 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(99 / w)  - offsetX,y: CGFloat(259 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(50 / w)  - offsetX,y: CGFloat(220 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(13 / w)  - offsetX,y: CGFloat(212 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(6 / w)  - offsetX,y: CGFloat(191 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(20 / w)  - offsetX,y: CGFloat(185 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(38 / w)  - offsetX,y: CGFloat(188 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(48 / w)  - offsetX,y: CGFloat(201 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(120 / w)  - offsetX,y: CGFloat(212 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(135 / w)  - offsetX,y: CGFloat(198 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(129 / w)  - offsetX,y: CGFloat(174 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(111 / w)  - offsetX,y: CGFloat(155 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(116 / w)  - offsetX,y: CGFloat(125 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(108 / w)  - offsetX,y: CGFloat(109 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(63 / w)  - offsetX,y: CGFloat(126 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(42 / w)  - offsetX,y: CGFloat(112 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(54 / w)  - offsetX,y: CGFloat(85 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(78 / w)  - offsetX,y: CGFloat(86 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(101 / w)  - offsetX,y: CGFloat(94 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(130 / w)  - offsetX,y: CGFloat(100 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(154 / w)  - offsetX,y: CGFloat(141 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(180 / w)  - offsetX,y: CGFloat(141 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(199 / w)  - offsetX,y: CGFloat(111 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(181 / w)  - offsetX,y: CGFloat(84 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(180 / w)  - offsetX,y: CGFloat(81 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(160 / w)  - offsetX,y: CGFloat(80 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(158 / w)  - offsetX,y: CGFloat(66 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(168 / w)  - offsetX,y: CGFloat(56 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(180 / w)  - offsetX,y: CGFloat(61 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(197 / w)  - offsetX,y: CGFloat(47 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(180 / w)  - offsetX,y: CGFloat(31 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(188 / w)  - offsetX,y: CGFloat(20 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(208 / w)  - offsetX,y: CGFloat(16 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(214 / w)  - offsetX,y: CGFloat(7 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(227 / w)  - offsetX,y: CGFloat(14 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(223 / w)  - offsetX,y: CGFloat(25 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(236 / w)  - offsetX,y: CGFloat(39 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(248 / w)  - offsetX,y: CGFloat(35 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(260 / w)  - offsetX,y: CGFloat(50 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(236 / w)  - offsetX,y: CGFloat(64 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(239 / w)  - offsetX,y: CGFloat(90 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(247 / w)  - offsetX,y: CGFloat(86 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(256 / w)  - offsetX,y: CGFloat(100 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(283 / w)  - offsetX,y: CGFloat(91 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w)  - offsetX,y: CGFloat(104 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w)  - offsetX,y: CGFloat(124 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(287 / w)  - offsetX,y: CGFloat(129 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(309 / w)  - offsetX,y: CGFloat(147 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(313 / w)  - offsetX,y: CGFloat(152 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(300 / w)  - offsetX,y: CGFloat(189 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(281 / w)  - offsetX,y: CGFloat(195 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(281 / w)  - offsetX,y: CGFloat(225 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(310 / w)  - offsetX,y: CGFloat(229 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(336 / w)  - offsetX,y: CGFloat(217 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(342 / w)  - offsetX,y: CGFloat(192 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(357 / w)  - offsetX,y: CGFloat(177 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(378 / w)  - offsetX,y: CGFloat(172 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(398 / w)  - offsetX,y: CGFloat(177 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(400 / w)  - offsetX,y: CGFloat(202 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(383 / w)  - offsetX,y: CGFloat(225 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(348 / w)  - offsetX,y: CGFloat(230 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(332 / w)  - offsetX,y: CGFloat(255 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w)  - offsetX,y: CGFloat(265 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(262 / w)  - offsetX,y: CGFloat(254 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(245 / w)  - offsetX,y: CGFloat(299 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(245 / w)  - offsetX,y: CGFloat(331 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(274 / w)  - offsetX,y: CGFloat(344 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(276 / w)  - offsetX,y: CGFloat(365 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(259 / w)  - offsetX,y: CGFloat(376 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(244 / w)  - offsetX,y: CGFloat(370 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(244 / w)  - offsetX,y: CGFloat(425 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(216 / w)  - offsetX,y: CGFloat(478 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func huhBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 2.9
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(336 / w) - offsetX,y: CGFloat(438 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(279 / w)  - offsetX,y: CGFloat(390 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(265 / w)  - offsetX,y: CGFloat(324 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(199 / w)  - offsetX,y: CGFloat(309 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(120 / w)  - offsetX,y: CGFloat(241 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(63 / w)  - offsetX,y: CGFloat(147 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(23 / w)  - offsetX,y: CGFloat(86 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(3 / w)  - offsetX,y: CGFloat(62 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(20 / w)  - offsetX,y: CGFloat(29 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(53 / w)  - offsetX,y: CGFloat(32 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(72 / w)  - offsetX,y: CGFloat(14 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(108 / w)  - offsetX,y: CGFloat(6 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(157 / w)  - offsetX,y: CGFloat(10 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(185 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(217 / w)  - offsetX,y: CGFloat(23 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(210 / w)  - offsetX,y: CGFloat(46 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(246 / w)  - offsetX,y: CGFloat(61 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(239 / w)  - offsetX,y: CGFloat(71 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(220 / w)  - offsetX,y: CGFloat(64 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(203 / w)  - offsetX,y: CGFloat(65 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(187 / w)  - offsetX,y: CGFloat(94 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(198 / w)  - offsetX,y: CGFloat(136 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(293 / w)  - offsetX,y: CGFloat(230 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(305 / w)  - offsetX,y: CGFloat(270 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(314 / w)  - offsetX,y: CGFloat(297 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(352 / w)  - offsetX,y: CGFloat(302 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(361 / w)  - offsetX,y: CGFloat(286 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(356 / w)  - offsetX,y: CGFloat(260 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(372 / w)  - offsetX,y: CGFloat(253 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(375 / w)  - offsetX,y: CGFloat(295 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(356 / w)  - offsetX,y: CGFloat(321 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(339 / w)  - offsetX,y: CGFloat(361 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(363 / w)  - offsetX,y: CGFloat(365 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(388 / w)  - offsetX,y: CGFloat(358 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(403 / w)  - offsetX,y: CGFloat(365 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(394 / w)  - offsetX,y: CGFloat(378 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(360 / w)  - offsetX,y: CGFloat(383 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(319 / w)  - offsetX,y: CGFloat(368 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(301 / w)  - offsetX,y: CGFloat(400 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(344 / w)  - offsetX,y: CGFloat(413 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(349 / w)  - offsetX,y: CGFloat(431 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func diamantierBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 1.85
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(163 / w) - offsetX,y: CGFloat(404 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(83 / w)  - offsetX,y: CGFloat(281 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(73 / w)  - offsetX,y: CGFloat(244 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(53 / w)  - offsetX,y: CGFloat(220 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(11 / w)  - offsetX,y: CGFloat(226 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(3 / w)  - offsetX,y: CGFloat(188 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(98 / w)  - offsetX,y: CGFloat(86 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(100 / w)  - offsetX,y: CGFloat(46 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(132 / w)  - offsetX,y: CGFloat(6 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(155 / w)  - offsetX,y: CGFloat(32 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(197 / w)  - offsetX,y: CGFloat(39 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(207 / w)  - offsetX,y: CGFloat(15 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(227 / w)  - offsetX,y: CGFloat(4 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(247 / w)  - offsetX,y: CGFloat(49 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(270 / w)  - offsetX,y: CGFloat(44 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(281 / w)  - offsetX,y: CGFloat(93 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(293 / w)  - offsetX,y: CGFloat(85 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(286 / w)  - offsetX,y: CGFloat(161 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(244 / w)  - offsetX,y: CGFloat(199 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(199 / w)  - offsetX,y: CGFloat(209 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(230 / w)  - offsetX,y: CGFloat(250 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func plushBody(sprite: SKSpriteNode) -> SKPhysicsBody{
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 2.2
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(199 / w) - offsetX,y: CGFloat(414 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(57 / w)  - offsetX,y: CGFloat(413 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(29 / w)  - offsetX,y: CGFloat(357 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(33 / w)  - offsetX,y: CGFloat(293 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(69 / w)  - offsetX,y: CGFloat(253 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(78 / w)  - offsetX,y: CGFloat(154 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(21 / w)  - offsetX,y: CGFloat(109 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(13 / w)  - offsetX,y: CGFloat(53 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(59 / w)  - offsetX,y: CGFloat(23 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(119 / w)  - offsetX,y: CGFloat(13 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(213 / w)  - offsetX,y: CGFloat(56 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(206 / w)  - offsetX,y: CGFloat(124 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(184 / w)  - offsetX,y: CGFloat(151 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(196 / w)  - offsetX,y: CGFloat(219 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(225 / w)  - offsetX,y: CGFloat(262 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(232 / w)  - offsetX,y: CGFloat(361 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }
    
    private class func bigeyyyBody(sprite: SKSpriteNode) -> SKPhysicsBody{
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 2.35
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(112 / w) - offsetX,y: CGFloat(294 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(70 / w)  - offsetX,y: CGFloat(224 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(82 / w)  - offsetX,y: CGFloat(172 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(7 / w)  - offsetX,y: CGFloat(160 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(58 / w)  - offsetX,y: CGFloat(114 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(25 / w)  - offsetX,y: CGFloat(84 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(101 / w)  - offsetX,y: CGFloat(53 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(129 / w)  - offsetX,y: CGFloat(24 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(194 / w)  - offsetX,y: CGFloat(3 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(279 / w)  - offsetX,y: CGFloat(43 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(290 / w)  - offsetX,y: CGFloat(81 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(355 / w)  - offsetX,y: CGFloat(42 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(335 / w)  - offsetX,y: CGFloat(18 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(371 / w)  - offsetX,y: CGFloat(37 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(384 / w)  - offsetX,y: CGFloat(83 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(454 / w)  - offsetX,y: CGFloat(132 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(478 / w)  - offsetX,y: CGFloat(195 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(417 / w)  - offsetX,y: CGFloat(360 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(284 / w)  - offsetX,y: CGFloat(435 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(179 / w)  - offsetX,y: CGFloat(446 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(63 / w)  - offsetX,y: CGFloat(391 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }
    
    private class func crystalioBody(sprite: SKSpriteNode) -> SKPhysicsBody{
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 4
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(142 / w) - offsetX,y: CGFloat(411 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(93 / w)  - offsetX,y: CGFloat(392 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(20 / w)  - offsetX,y: CGFloat(258 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(87 / w)  - offsetX,y: CGFloat(12 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(107 / w)  - offsetX,y: CGFloat(9 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(260 / w)  - offsetX,y: CGFloat(235 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(251 / w)  - offsetX,y: CGFloat(284 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(179 / w)  - offsetX,y: CGFloat(392 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }
    
    private class func slimeBody(sprite: SKSpriteNode) -> SKPhysicsBody{
        sprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 4.5
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(295 / w) - offsetX,y: CGFloat(393 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(221 / w)  - offsetX,y: CGFloat(372 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(223 / w)  - offsetX,y: CGFloat(356 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(267 / w)  - offsetX,y: CGFloat(300 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(32 / w)  - offsetX,y: CGFloat(217 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(12 / w)  - offsetX,y: CGFloat(183 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(26 / w)  - offsetX,y: CGFloat(140 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(4 / w)  - offsetX,y: CGFloat(93 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(28 / w)  - offsetX,y: CGFloat(68 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(98 / w)  - offsetX,y: CGFloat(93 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(129 / w)  - offsetX,y: CGFloat(84 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(131 / w)  - offsetX,y: CGFloat(6 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(159 / w)  - offsetX,y: CGFloat(13 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(183 / w)  - offsetX,y: CGFloat(78 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(208 / w)  - offsetX,y: CGFloat(84 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(243 / w)  - offsetX,y: CGFloat(28 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(265 / w)  - offsetX,y: CGFloat(29 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(286 / w)  - offsetX,y: CGFloat(87 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(304 / w)  - offsetX,y: CGFloat(87 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(332 / w)  - offsetX,y: CGFloat(58 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(352 / w)  - offsetX,y: CGFloat(66 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(352 / w)  - offsetX,y: CGFloat(132 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(371 / w)  - offsetX,y: CGFloat(154 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(361 / w)  - offsetX,y: CGFloat(244 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(385 / w)  - offsetX,y: CGFloat(278 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(420 / w)  - offsetX,y: CGFloat(266 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(445 / w)  - offsetX,y: CGFloat(292 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(426 / w)  - offsetX,y: CGFloat(326 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(384 / w)  - offsetX,y: CGFloat(321 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(349 / w)  - offsetX,y: CGFloat(334 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(380 / w)  - offsetX,y: CGFloat(383 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }
    
    private class func crystalLevelBody(sprite: SKSpriteNode) -> SKPhysicsBody{
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 0.63 * 0.881
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(344 / w) - offsetX,y: CGFloat(899 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(345 / w)  - offsetX,y: CGFloat(894 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(328 / w)  - offsetX,y: CGFloat(889 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(307 / w)  - offsetX,y: CGFloat(893 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w)  - offsetX,y: CGFloat(889 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(283 / w)  - offsetX,y: CGFloat(890 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(277 / w)  - offsetX,y: CGFloat(871 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(253 / w)  - offsetX,y: CGFloat(867 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(227 / w)  - offsetX,y: CGFloat(870 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(200 / w)  - offsetX,y: CGFloat(896 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(166 / w)  - offsetX,y: CGFloat(883 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(132 / w)  - offsetX,y: CGFloat(887 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(110 / w)  - offsetX,y: CGFloat(888 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(79 / w)  - offsetX,y: CGFloat(896 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(77 / w)  - offsetX,y: CGFloat(898 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(30 / w)  - offsetX,y: CGFloat(895 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(18 / w)  - offsetX,y: CGFloat(895 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(18 / w)  - offsetX,y: CGFloat(885 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(38 / w)  - offsetX,y: CGFloat(881 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(32 / w)  - offsetX,y: CGFloat(866 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(39 / w)  - offsetX,y: CGFloat(856 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(36 / w)  - offsetX,y: CGFloat(840 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(38 / w)  - offsetX,y: CGFloat(827 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(79 / w)  - offsetX,y: CGFloat(814 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(74 / w)  - offsetX,y: CGFloat(789 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(56 / w)  - offsetX,y: CGFloat(777 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(25 / w)  - offsetX,y: CGFloat(773 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(19 / w)  - offsetX,y: CGFloat(761 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(44 / w)  - offsetX,y: CGFloat(739 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(46 / w)  - offsetX,y: CGFloat(719 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(83 / w)  - offsetX,y: CGFloat(688 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(98 / w)  - offsetX,y: CGFloat(674 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(145 / w)  - offsetX,y: CGFloat(678 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(153 / w)  - offsetX,y: CGFloat(695 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(175 / w)  - offsetX,y: CGFloat(706 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(181 / w)  - offsetX,y: CGFloat(702 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(188 / w)  - offsetX,y: CGFloat(689 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(205 / w)  - offsetX,y: CGFloat(701 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(229 / w)  - offsetX,y: CGFloat(700 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(245 / w)  - offsetX,y: CGFloat(729 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(257 / w)  - offsetX,y: CGFloat(733 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(271 / w)  - offsetX,y: CGFloat(729 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(264 / w)  - offsetX,y: CGFloat(716 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(259 / w)  - offsetX,y: CGFloat(700 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(258 / w)  - offsetX,y: CGFloat(686 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(252 / w)  - offsetX,y: CGFloat(647 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(241 / w)  - offsetX,y: CGFloat(614 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(243 / w)  - offsetX,y: CGFloat(605 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(234 / w)  - offsetX,y: CGFloat(556 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(240 / w)  - offsetX,y: CGFloat(547 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(234 / w)  - offsetX,y: CGFloat(536 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(209 / w)  - offsetX,y: CGFloat(528 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(188 / w)  - offsetX,y: CGFloat(531 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(176 / w)  - offsetX,y: CGFloat(515 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(154 / w)  - offsetX,y: CGFloat(508 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(133 / w)  - offsetX,y: CGFloat(508 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(109 / w)  - offsetX,y: CGFloat(510 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(83 / w)  - offsetX,y: CGFloat(506 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(86 / w)  - offsetX,y: CGFloat(493 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(78 / w)  - offsetX,y: CGFloat(490 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(59 / w)  - offsetX,y: CGFloat(494 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(53 / w)  - offsetX,y: CGFloat(474 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(67 / w)  - offsetX,y: CGFloat(459 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(76 / w)  - offsetX,y: CGFloat(432 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(99 / w)  - offsetX,y: CGFloat(442 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(106 / w)  - offsetX,y: CGFloat(420 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(85 / w)  - offsetX,y: CGFloat(417 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(89 / w)  - offsetX,y: CGFloat(406 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(67 / w)  - offsetX,y: CGFloat(387 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(50 / w)  - offsetX,y: CGFloat(384 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(66 / w)  - offsetX,y: CGFloat(367 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(68 / w)  - offsetX,y: CGFloat(356 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(16 / w)  - offsetX,y: CGFloat(365 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(0 / w)  - offsetX,y: CGFloat(356 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1 / w)  - offsetX,y: CGFloat(162 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(22 / w)  - offsetX,y: CGFloat(158 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(38 / w)  - offsetX,y: CGFloat(189 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(51 / w)  - offsetX,y: CGFloat(187 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(55 / w)  - offsetX,y: CGFloat(174 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(42 / w)  - offsetX,y: CGFloat(158 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(47 / w)  - offsetX,y: CGFloat(147 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(60 / w)  - offsetX,y: CGFloat(145 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(64 / w)  - offsetX,y: CGFloat(139 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(42 / w)  - offsetX,y: CGFloat(132 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(60 / w)  - offsetX,y: CGFloat(92 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(67 / w)  - offsetX,y: CGFloat(91 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(80 / w)  - offsetX,y: CGFloat(117 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(117 / w)  - offsetX,y: CGFloat(102 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(132 / w)  - offsetX,y: CGFloat(106 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(142 / w)  - offsetX,y: CGFloat(116 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(147 / w)  - offsetX,y: CGFloat(82 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(144 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(152 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(187 / w)  - offsetX,y: CGFloat(0 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(180 / w)  - offsetX,y: CGFloat(11 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(185 / w)  - offsetX,y: CGFloat(21 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(202 / w)  - offsetX,y: CGFloat(22 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(206 / w)  - offsetX,y: CGFloat(51 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(219 / w)  - offsetX,y: CGFloat(64 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(235 / w)  - offsetX,y: CGFloat(80 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(260 / w)  - offsetX,y: CGFloat(121 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(276 / w)  - offsetX,y: CGFloat(132 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(286 / w)  - offsetX,y: CGFloat(141 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(282 / w)  - offsetX,y: CGFloat(165 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(279 / w)  - offsetX,y: CGFloat(186 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(295 / w)  - offsetX,y: CGFloat(185 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(298 / w)  - offsetX,y: CGFloat(217 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(320 / w)  - offsetX,y: CGFloat(232 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(321 / w)  - offsetX,y: CGFloat(260 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(306 / w)  - offsetX,y: CGFloat(254 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(308 / w)  - offsetX,y: CGFloat(281 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(314 / w)  - offsetX,y: CGFloat(287 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(319 / w)  - offsetX,y: CGFloat(273 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(342 / w)  - offsetX,y: CGFloat(272 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(344 / w)  - offsetX,y: CGFloat(290 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(354 / w)  - offsetX,y: CGFloat(292 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(355 / w)  - offsetX,y: CGFloat(275 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(374 / w)  - offsetX,y: CGFloat(259 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(376 / w)  - offsetX,y: CGFloat(235 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(356 / w)  - offsetX,y: CGFloat(222 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(352 / w)  - offsetX,y: CGFloat(151 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(344 / w)  - offsetX,y: CGFloat(109 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(358 / w)  - offsetX,y: CGFloat(105 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(363 / w)  - offsetX,y: CGFloat(111 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(382 / w)  - offsetX,y: CGFloat(116 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(415 / w)  - offsetX,y: CGFloat(136 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(424 / w)  - offsetX,y: CGFloat(158 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(434 / w)  - offsetX,y: CGFloat(159 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(451 / w)  - offsetX,y: CGFloat(193 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(469 / w)  - offsetX,y: CGFloat(190 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(471 / w)  - offsetX,y: CGFloat(212 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(496 / w)  - offsetX,y: CGFloat(230 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(506 / w)  - offsetX,y: CGFloat(219 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(519 / w)  - offsetX,y: CGFloat(233 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(519 / w)  - offsetX,y: CGFloat(248 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(539 / w)  - offsetX,y: CGFloat(259 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(538 / w)  - offsetX,y: CGFloat(241 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(524 / w)  - offsetX,y: CGFloat(231 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(531 / w)  - offsetX,y: CGFloat(195 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(521 / w)  - offsetX,y: CGFloat(167 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(511 / w)  - offsetX,y: CGFloat(130 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(474 / w)  - offsetX,y: CGFloat(122 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(468 / w)  - offsetX,y: CGFloat(108 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(476 / w)  - offsetX,y: CGFloat(98 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(455 / w)  - offsetX,y: CGFloat(69 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(461 / w)  - offsetX,y: CGFloat(57 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(441 / w)  - offsetX,y: CGFloat(11 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(461 / w)  - offsetX,y: CGFloat(22 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(473 / w)  - offsetX,y: CGFloat(13 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(501 / w)  - offsetX,y: CGFloat(34 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(502 / w)  - offsetX,y: CGFloat(46 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(511 / w)  - offsetX,y: CGFloat(48 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(533 / w)  - offsetX,y: CGFloat(43 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(540 / w)  - offsetX,y: CGFloat(36 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(564 / w)  - offsetX,y: CGFloat(31 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(609 / w)  - offsetX,y: CGFloat(75 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(618 / w)  - offsetX,y: CGFloat(78 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(639 / w)  - offsetX,y: CGFloat(74 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(629 / w)  - offsetX,y: CGFloat(52 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(640 / w)  - offsetX,y: CGFloat(43 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(646 / w)  - offsetX,y: CGFloat(27 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(701 / w)  - offsetX,y: CGFloat(25 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(711 / w)  - offsetX,y: CGFloat(57 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(724 / w)  - offsetX,y: CGFloat(62 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(726 / w)  - offsetX,y: CGFloat(80 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(773 / w)  - offsetX,y: CGFloat(148 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(775 / w)  - offsetX,y: CGFloat(163 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(783 / w)  - offsetX,y: CGFloat(167 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(780 / w)  - offsetX,y: CGFloat(185 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(790 / w)  - offsetX,y: CGFloat(213 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(808 / w)  - offsetX,y: CGFloat(215 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(814 / w)  - offsetX,y: CGFloat(210 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(831 / w)  - offsetX,y: CGFloat(213 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(839 / w)  - offsetX,y: CGFloat(210 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(839 / w)  - offsetX,y: CGFloat(203 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(831 / w)  - offsetX,y: CGFloat(205 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(819 / w)  - offsetX,y: CGFloat(201 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(811 / w)  - offsetX,y: CGFloat(201 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(808 / w)  - offsetX,y: CGFloat(170 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(814 / w)  - offsetX,y: CGFloat(163 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(808 / w)  - offsetX,y: CGFloat(150 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(815 / w)  - offsetX,y: CGFloat(140 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(801 / w)  - offsetX,y: CGFloat(56 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(836 / w)  - offsetX,y: CGFloat(37 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(846 / w)  - offsetX,y: CGFloat(50 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(852 / w)  - offsetX,y: CGFloat(63 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(855 / w)  - offsetX,y: CGFloat(100 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(872 / w)  - offsetX,y: CGFloat(110 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(883 / w)  - offsetX,y: CGFloat(133 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(894 / w)  - offsetX,y: CGFloat(162 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(902 / w)  - offsetX,y: CGFloat(169 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(903 / w)  - offsetX,y: CGFloat(161 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(916 / w)  - offsetX,y: CGFloat(147 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(919 / w)  - offsetX,y: CGFloat(139 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(924 / w)  - offsetX,y: CGFloat(137 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(937 / w)  - offsetX,y: CGFloat(141 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(940 / w)  - offsetX,y: CGFloat(140 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(934 / w)  - offsetX,y: CGFloat(124 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(941 / w)  - offsetX,y: CGFloat(116 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(942 / w)  - offsetX,y: CGFloat(110 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(949 / w)  - offsetX,y: CGFloat(107 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(957 / w)  - offsetX,y: CGFloat(97 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(962 / w)  - offsetX,y: CGFloat(96 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(961 / w)  - offsetX,y: CGFloat(73 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(975 / w)  - offsetX,y: CGFloat(67 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(960 / w)  - offsetX,y: CGFloat(62 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(967 / w)  - offsetX,y: CGFloat(46 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(980 / w)  - offsetX,y: CGFloat(47 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(994 / w)  - offsetX,y: CGFloat(35 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1016 / w)  - offsetX,y: CGFloat(54 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1015 / w)  - offsetX,y: CGFloat(61 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1023 / w)  - offsetX,y: CGFloat(69 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1017 / w)  - offsetX,y: CGFloat(105 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1025 / w)  - offsetX,y: CGFloat(124 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1031 / w)  - offsetX,y: CGFloat(127 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1027 / w)  - offsetX,y: CGFloat(136 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1049 / w)  - offsetX,y: CGFloat(207 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1018 / w)  - offsetX,y: CGFloat(236 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1007 / w)  - offsetX,y: CGFloat(236 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1004 / w)  - offsetX,y: CGFloat(250 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1001 / w)  - offsetX,y: CGFloat(267 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(994 / w)  - offsetX,y: CGFloat(290 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1004 / w)  - offsetX,y: CGFloat(308 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(996 / w)  - offsetX,y: CGFloat(325 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1000 / w)  - offsetX,y: CGFloat(356 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1009 / w)  - offsetX,y: CGFloat(401 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(998 / w)  - offsetX,y: CGFloat(432 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1015 / w)  - offsetX,y: CGFloat(444 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1019 / w)  - offsetX,y: CGFloat(432 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1038 / w)  - offsetX,y: CGFloat(439 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1037 / w)  - offsetX,y: CGFloat(446 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1045 / w)  - offsetX,y: CGFloat(448 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1047 / w)  - offsetX,y: CGFloat(436 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1055 / w)  - offsetX,y: CGFloat(415 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1063 / w)  - offsetX,y: CGFloat(371 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1063 / w)  - offsetX,y: CGFloat(349 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1067 / w)  - offsetX,y: CGFloat(351 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1076 / w)  - offsetX,y: CGFloat(325 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1064 / w)  - offsetX,y: CGFloat(306 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1090 / w)  - offsetX,y: CGFloat(269 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1105 / w)  - offsetX,y: CGFloat(269 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1109 / w)  - offsetX,y: CGFloat(253 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1122 / w)  - offsetX,y: CGFloat(253 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1128 / w)  - offsetX,y: CGFloat(244 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1141 / w)  - offsetX,y: CGFloat(245 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1141 / w)  - offsetX,y: CGFloat(224 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1167 / w)  - offsetX,y: CGFloat(196 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1177 / w)  - offsetX,y: CGFloat(204 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1202 / w)  - offsetX,y: CGFloat(186 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1196 / w)  - offsetX,y: CGFloat(175 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1203 / w)  - offsetX,y: CGFloat(159 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1216 / w)  - offsetX,y: CGFloat(160 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1218 / w)  - offsetX,y: CGFloat(145 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1235 / w)  - offsetX,y: CGFloat(132 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1244 / w)  - offsetX,y: CGFloat(147 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1240 / w)  - offsetX,y: CGFloat(159 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1270 / w)  - offsetX,y: CGFloat(161 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1270 / w)  - offsetX,y: CGFloat(141 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1279 / w)  - offsetX,y: CGFloat(128 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1258 / w)  - offsetX,y: CGFloat(110 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1300 / w)  - offsetX,y: CGFloat(100 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1299 / w)  - offsetX,y: CGFloat(111 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1308 / w)  - offsetX,y: CGFloat(111 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1313 / w)  - offsetX,y: CGFloat(96 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1303 / w)  - offsetX,y: CGFloat(88 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1278 / w)  - offsetX,y: CGFloat(83 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1231 / w)  - offsetX,y: CGFloat(94 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1214 / w)  - offsetX,y: CGFloat(110 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1176 / w)  - offsetX,y: CGFloat(22 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1149 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1238 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1245 / w)  - offsetX,y: CGFloat(10 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1258 / w)  - offsetX,y: CGFloat(7 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1261 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1350 / w)  - offsetX,y: CGFloat(0 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1351 / w)  - offsetX,y: CGFloat(19 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1368 / w)  - offsetX,y: CGFloat(1 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1376 / w)  - offsetX,y: CGFloat(15 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1384 / w)  - offsetX,y: CGFloat(19 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1393 / w)  - offsetX,y: CGFloat(9 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1404 / w)  - offsetX,y: CGFloat(14 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1401 / w)  - offsetX,y: CGFloat(30 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1417 / w)  - offsetX,y: CGFloat(31 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1424 / w)  - offsetX,y: CGFloat(63 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1437 / w)  - offsetX,y: CGFloat(66 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1439 / w)  - offsetX,y: CGFloat(277 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1413 / w)  - offsetX,y: CGFloat(293 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1412 / w)  - offsetX,y: CGFloat(308 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1384 / w)  - offsetX,y: CGFloat(304 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1372 / w)  - offsetX,y: CGFloat(321 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1328 / w)  - offsetX,y: CGFloat(306 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1318 / w)  - offsetX,y: CGFloat(308 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1308 / w)  - offsetX,y: CGFloat(295 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1317 / w)  - offsetX,y: CGFloat(342 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1311 / w)  - offsetX,y: CGFloat(366 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1336 / w)  - offsetX,y: CGFloat(397 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1352 / w)  - offsetX,y: CGFloat(395 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1351 / w)  - offsetX,y: CGFloat(412 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1392 / w)  - offsetX,y: CGFloat(477 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1415 / w)  - offsetX,y: CGFloat(495 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1393 / w)  - offsetX,y: CGFloat(521 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1377 / w)  - offsetX,y: CGFloat(511 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1351 / w)  - offsetX,y: CGFloat(500 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1344 / w)  - offsetX,y: CGFloat(478 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1313 / w)  - offsetX,y: CGFloat(478 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1304 / w)  - offsetX,y: CGFloat(466 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1281 / w)  - offsetX,y: CGFloat(466 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1265 / w)  - offsetX,y: CGFloat(482 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1253 / w)  - offsetX,y: CGFloat(474 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1229 / w)  - offsetX,y: CGFloat(461 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1213 / w)  - offsetX,y: CGFloat(458 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1204 / w)  - offsetX,y: CGFloat(467 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1216 / w)  - offsetX,y: CGFloat(472 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1229 / w)  - offsetX,y: CGFloat(485 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1202 / w)  - offsetX,y: CGFloat(492 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1195 / w)  - offsetX,y: CGFloat(499 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1215 / w)  - offsetX,y: CGFloat(512 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1283 / w)  - offsetX,y: CGFloat(553 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1315 / w)  - offsetX,y: CGFloat(541 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1325 / w)  - offsetX,y: CGFloat(561 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1341 / w)  - offsetX,y: CGFloat(568 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1349 / w)  - offsetX,y: CGFloat(599 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1370 / w)  - offsetX,y: CGFloat(613 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1356 / w)  - offsetX,y: CGFloat(631 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1337 / w)  - offsetX,y: CGFloat(629 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1317 / w)  - offsetX,y: CGFloat(651 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1328 / w)  - offsetX,y: CGFloat(674 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1334 / w)  - offsetX,y: CGFloat(689 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1356 / w)  - offsetX,y: CGFloat(708 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1365 / w)  - offsetX,y: CGFloat(729 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1434 / w)  - offsetX,y: CGFloat(753 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1438 / w)  - offsetX,y: CGFloat(763 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1438 / w)  - offsetX,y: CGFloat(816 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1426 / w)  - offsetX,y: CGFloat(822 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1428 / w)  - offsetX,y: CGFloat(833 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1411 / w)  - offsetX,y: CGFloat(830 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1390 / w)  - offsetX,y: CGFloat(805 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1378 / w)  - offsetX,y: CGFloat(816 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1364 / w)  - offsetX,y: CGFloat(816 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1349 / w)  - offsetX,y: CGFloat(846 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1350 / w)  - offsetX,y: CGFloat(852 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1317 / w)  - offsetX,y: CGFloat(867 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1318 / w)  - offsetX,y: CGFloat(872 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1306 / w)  - offsetX,y: CGFloat(884 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1297 / w)  - offsetX,y: CGFloat(886 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1291 / w)  - offsetX,y: CGFloat(882 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1282 / w)  - offsetX,y: CGFloat(885 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1273 / w)  - offsetX,y: CGFloat(879 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1256 / w)  - offsetX,y: CGFloat(872 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1260 / w)  - offsetX,y: CGFloat(859 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1256 / w)  - offsetX,y: CGFloat(852 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1261 / w)  - offsetX,y: CGFloat(844 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1256 / w)  - offsetX,y: CGFloat(831 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1274 / w)  - offsetX,y: CGFloat(830 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1280 / w)  - offsetX,y: CGFloat(840 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1285 / w)  - offsetX,y: CGFloat(838 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1277 / w)  - offsetX,y: CGFloat(830 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1273 / w)  - offsetX,y: CGFloat(818 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1266 / w)  - offsetX,y: CGFloat(815 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1258 / w)  - offsetX,y: CGFloat(816 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1248 / w)  - offsetX,y: CGFloat(829 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1236 / w)  - offsetX,y: CGFloat(828 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1223 / w)  - offsetX,y: CGFloat(833 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1216 / w)  - offsetX,y: CGFloat(818 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1190 / w)  - offsetX,y: CGFloat(826 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1184 / w)  - offsetX,y: CGFloat(813 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1162 / w)  - offsetX,y: CGFloat(821 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1162 / w)  - offsetX,y: CGFloat(828 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1146 / w)  - offsetX,y: CGFloat(898 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1080 / w)  - offsetX,y: CGFloat(897 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1073 / w)  - offsetX,y: CGFloat(884 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1048 / w)  - offsetX,y: CGFloat(883 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1050 / w)  - offsetX,y: CGFloat(864 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1036 / w)  - offsetX,y: CGFloat(847 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1007 / w)  - offsetX,y: CGFloat(843 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(958 / w)  - offsetX,y: CGFloat(898 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(943 / w)  - offsetX,y: CGFloat(898 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(920 / w)  - offsetX,y: CGFloat(889 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(906 / w)  - offsetX,y: CGFloat(852 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(892 / w)  - offsetX,y: CGFloat(844 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(879 / w)  - offsetX,y: CGFloat(848 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(874 / w)  - offsetX,y: CGFloat(866 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(864 / w)  - offsetX,y: CGFloat(863 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(860 / w)  - offsetX,y: CGFloat(876 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(849 / w)  - offsetX,y: CGFloat(899 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(723 / w)  - offsetX,y: CGFloat(898 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(727 / w)  - offsetX,y: CGFloat(886 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(740 / w)  - offsetX,y: CGFloat(882 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(740 / w)  - offsetX,y: CGFloat(860 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(736 / w)  - offsetX,y: CGFloat(857 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(717 / w)  - offsetX,y: CGFloat(871 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(699 / w)  - offsetX,y: CGFloat(868 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(684 / w)  - offsetX,y: CGFloat(854 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(692 / w)  - offsetX,y: CGFloat(846 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(695 / w)  - offsetX,y: CGFloat(818 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(686 / w)  - offsetX,y: CGFloat(806 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(684 / w)  - offsetX,y: CGFloat(785 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(700 / w)  - offsetX,y: CGFloat(787 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(704 / w)  - offsetX,y: CGFloat(772 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(688 / w)  - offsetX,y: CGFloat(756 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(682 / w)  - offsetX,y: CGFloat(770 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(665 / w)  - offsetX,y: CGFloat(773 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(656 / w)  - offsetX,y: CGFloat(759 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(643 / w)  - offsetX,y: CGFloat(744 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(640 / w)  - offsetX,y: CGFloat(718 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(658 / w)  - offsetX,y: CGFloat(712 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(652 / w)  - offsetX,y: CGFloat(708 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(634 / w)  - offsetX,y: CGFloat(713 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(620 / w)  - offsetX,y: CGFloat(701 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(622 / w)  - offsetX,y: CGFloat(659 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(626 / w)  - offsetX,y: CGFloat(645 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(642 / w)  - offsetX,y: CGFloat(646 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(641 / w)  - offsetX,y: CGFloat(624 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(647 / w)  - offsetX,y: CGFloat(601 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(662 / w)  - offsetX,y: CGFloat(601 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(646 / w)  - offsetX,y: CGFloat(589 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(642 / w)  - offsetX,y: CGFloat(569 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(641 / w)  - offsetX,y: CGFloat(558 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(657 / w)  - offsetX,y: CGFloat(548 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(651 / w)  - offsetX,y: CGFloat(537 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(631 / w)  - offsetX,y: CGFloat(550 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(615 / w)  - offsetX,y: CGFloat(564 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(606 / w)  - offsetX,y: CGFloat(550 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(595 / w)  - offsetX,y: CGFloat(556 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(595 / w)  - offsetX,y: CGFloat(578 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(595 / w)  - offsetX,y: CGFloat(591 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(581 / w)  - offsetX,y: CGFloat(600 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(590 / w)  - offsetX,y: CGFloat(611 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(590 / w)  - offsetX,y: CGFloat(625 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(570 / w)  - offsetX,y: CGFloat(635 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(571 / w)  - offsetX,y: CGFloat(655 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(564 / w)  - offsetX,y: CGFloat(658 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(517 / w)  - offsetX,y: CGFloat(713 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(505 / w)  - offsetX,y: CGFloat(706 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(492 / w)  - offsetX,y: CGFloat(719 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(482 / w)  - offsetX,y: CGFloat(751 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(473 / w)  - offsetX,y: CGFloat(750 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(466 / w)  - offsetX,y: CGFloat(762 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(467 / w)  - offsetX,y: CGFloat(771 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(431 / w)  - offsetX,y: CGFloat(825 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(402 / w)  - offsetX,y: CGFloat(880 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(404 / w)  - offsetX,y: CGFloat(897 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(edgeLoopFrom: path)
    }
    
    private class func crystalKeyBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 6.5
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(86 / w) - offsetX,y: CGFloat(466 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(1 / w)  - offsetX,y: CGFloat(405 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(0 / w)  - offsetX,y: CGFloat(292 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(92 / w)  - offsetX,y: CGFloat(210 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(92 / w)  - offsetX,y: CGFloat(59 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(148 / w)  - offsetX,y: CGFloat(6 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(204 / w)  - offsetX,y: CGFloat(54 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(207 / w)  - offsetX,y: CGFloat(210 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(295 / w)  - offsetX,y: CGFloat(287 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(297 / w)  - offsetX,y: CGFloat(401 / w) - offsetY));
        path.addLine(to: CGPoint(x: CGFloat(213 / w)  - offsetX,y: CGFloat(465 / w) - offsetY));

        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func wanderBody(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 5
        let path = CGMutablePath()
        path.move(to: CGPoint(x: CGFloat(228 / w) - offsetX,y: CGFloat(44 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(136 / w) - offsetX,y: CGFloat(235 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(86 / w) - offsetX,y: CGFloat(280 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(36 / w) - offsetX,y: CGFloat(397 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(84 / w) - offsetX,y: CGFloat(500 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(360 / w) - offsetX,y: CGFloat(560 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(462 / w) - offsetX,y: CGFloat(521 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(559 / w) - offsetX,y: CGFloat(500 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(530 / w) - offsetX,y: CGFloat(302 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(461 / w) - offsetX,y: CGFloat(233 / w) - offsetY))
        path.addLine(to: CGPoint(x: CGFloat(428 / w) - offsetX,y: CGFloat(86 / w) - offsetY))
        path.closeSubpath()
        return SKPhysicsBody(polygonFrom: path)
    }

    private class func boundaries1_2(sprite: SKSpriteNode) -> SKPhysicsBody {
        let offsetX = sprite.size.width * sprite.anchorPoint.x - 25
        let offsetY = sprite.size.height * sprite.anchorPoint.y
        let w = 0.63
        let path1 = CGMutablePath()
        path1.move(to: CGPoint(x: CGFloat(303 / w) - offsetX, y: CGFloat(611 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(150 / w) - offsetX, y: CGFloat(531 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(247 / w) - offsetX, y: CGFloat(497 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(376 / w) - offsetX, y: CGFloat(320 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(449 / w) - offsetX, y: CGFloat(281 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(499 / w) - offsetX, y: CGFloat(318 / w) - offsetY));
        path1.addLine(to: CGPoint(x: CGFloat(413 / w) - offsetX, y: CGFloat(359 / w) - offsetY));
        path1.closeSubpath()

        let path2 = CGMutablePath()
        path2.move(to: CGPoint(x: CGFloat(920 / w) - offsetX, y: CGFloat(436 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(878 / w) - offsetX, y: CGFloat(380 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(851 / w) - offsetX, y: CGFloat(271 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(784 / w) - offsetX, y: CGFloat(232 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(703 / w) - offsetX, y: CGFloat(221 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(609 / w) - offsetX, y: CGFloat(234 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(566 / w) - offsetX, y: CGFloat(241 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(565 / w) - offsetX, y: CGFloat(203 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(612 / w) - offsetX, y: CGFloat(166 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(661 / w) - offsetX, y: CGFloat(139 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(754 / w) - offsetX, y: CGFloat(140 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(842 / w) - offsetX, y: CGFloat(149 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(922 / w) - offsetX, y: CGFloat(161 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(967 / w) - offsetX, y: CGFloat(197 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(975 / w) - offsetX, y: CGFloat(258 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(993 / w) - offsetX, y: CGFloat(341 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(993 / w) - offsetX, y: CGFloat(400 / w) - offsetY));
        path2.addLine(to: CGPoint(x: CGFloat(968 / w) - offsetX, y: CGFloat(448 / w) - offsetY));
        path2.closeSubpath()

        let path3 = CGMutablePath()
        path3.move(to: CGPoint(x: CGFloat(33 / w) - offsetX, y: CGFloat(402 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(64 / w) - offsetX, y: CGFloat(394 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(107 / w) - offsetX, y: CGFloat(352 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(147 / w) - offsetX, y: CGFloat(303 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(185 / w) - offsetX, y: CGFloat(248 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(177 / w) - offsetX, y: CGFloat(197 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(79 / w) - offsetX, y: CGFloat(136 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(58 / w) - offsetX, y: CGFloat(82 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(71 / w) - offsetX, y: CGFloat(38 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(97 / w) - offsetX, y: CGFloat(22 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(150 / w) - offsetX, y: CGFloat(10 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(188 / w) - offsetX, y: CGFloat(9 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(229 / w) - offsetX, y: CGFloat(20 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(249 / w) - offsetX, y: CGFloat(38 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(286 / w) - offsetX, y: CGFloat(49 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(321 / w) - offsetX, y: CGFloat(42 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(351 / w) - offsetX, y: CGFloat(33 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(388 / w) - offsetX, y: CGFloat(23 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(452 / w) - offsetX, y: CGFloat(25 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(543 / w) - offsetX, y: CGFloat(25 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(625 / w) - offsetX, y: CGFloat(21 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(705 / w) - offsetX, y: CGFloat(21 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(756 / w) - offsetX, y: CGFloat(11 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(811 / w) - offsetX, y: CGFloat(4 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(865 / w) - offsetX, y: CGFloat(18 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(894 / w) - offsetX, y: CGFloat(9 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(980 / w) - offsetX, y: CGFloat(17 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1071 / w) - offsetX, y: CGFloat(45 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1135 / w) - offsetX, y: CGFloat(75 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1161 / w) - offsetX, y: CGFloat(143 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1174 / w) - offsetX, y: CGFloat(206 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1179 / w) - offsetX, y: CGFloat(276 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1169 / w) - offsetX, y: CGFloat(329 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1153 / w) - offsetX, y: CGFloat(402 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1140 / w) - offsetX, y: CGFloat(464 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1119 / w) - offsetX, y: CGFloat(520 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1096 / w) - offsetX, y: CGFloat(567 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1076 / w) - offsetX, y: CGFloat(615 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1062 / w) - offsetX, y: CGFloat(634 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1007 / w) - offsetX, y: CGFloat(655 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(955 / w) - offsetX, y: CGFloat(666 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(903 / w) - offsetX, y: CGFloat(671 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(870 / w) - offsetX, y: CGFloat(678 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(857 / w) - offsetX, y: CGFloat(695 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(852 / w) - offsetX, y: CGFloat(718 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(858 / w) - offsetX, y: CGFloat(727 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(906 / w) - offsetX, y: CGFloat(734 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(937 / w) - offsetX, y: CGFloat(730 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(975 / w) - offsetX, y: CGFloat(723 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1006 / w) - offsetX, y: CGFloat(714 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1036 / w) - offsetX, y: CGFloat(706 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1071 / w) - offsetX, y: CGFloat(692 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1091 / w) - offsetX, y: CGFloat(680 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1105 / w) - offsetX, y: CGFloat(662 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1131 / w) - offsetX, y: CGFloat(622 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1145 / w) - offsetX, y: CGFloat(592 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1160 / w) - offsetX, y: CGFloat(564 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1179 / w) - offsetX, y: CGFloat(531 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1187 / w) - offsetX, y: CGFloat(510 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1218 / w) - offsetX, y: CGFloat(431 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1226 / w) - offsetX, y: CGFloat(411 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1232 / w) - offsetX, y: CGFloat(372 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1235 / w) - offsetX, y: CGFloat(345 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1241 / w) - offsetX, y: CGFloat(306 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1241 / w) - offsetX, y: CGFloat(283 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1247 / w) - offsetX, y: CGFloat(272 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1269 / w) - offsetX, y: CGFloat(267 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1290 / w) - offsetX, y: CGFloat(265 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1321 / w) - offsetX, y: CGFloat(275 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1351 / w) - offsetX, y: CGFloat(286 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1422 / w) - offsetX, y: CGFloat(301 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1448 / w) - offsetX, y: CGFloat(306 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1494 / w) - offsetX, y: CGFloat(315 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1528 / w) - offsetX, y: CGFloat(343 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1542 / w) - offsetX, y: CGFloat(355 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1561 / w) - offsetX, y: CGFloat(379 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1569 / w) - offsetX, y: CGFloat(393 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1583 / w) - offsetX, y: CGFloat(417 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1603 / w) - offsetX, y: CGFloat(426 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1615 / w) - offsetX, y: CGFloat(419 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1610 / w) - offsetX, y: CGFloat(383 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1600 / w) - offsetX, y: CGFloat(366 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1579 / w) - offsetX, y: CGFloat(334 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1562 / w) - offsetX, y: CGFloat(321 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1529 / w) - offsetX, y: CGFloat(297 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1494 / w) - offsetX, y: CGFloat(279 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1439 / w) - offsetX, y: CGFloat(261 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1389 / w) - offsetX, y: CGFloat(247 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1312 / w) - offsetX, y: CGFloat(232 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1255 / w) - offsetX, y: CGFloat(201 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1215 / w) - offsetX, y: CGFloat(144 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1205 / w) - offsetX, y: CGFloat(112 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1196 / w) - offsetX, y: CGFloat(80 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1189 / w) - offsetX, y: CGFloat(47 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1191 / w) - offsetX, y: CGFloat(16 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1198 / w) - offsetX, y: CGFloat(8 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1357 / w) - offsetX, y: CGFloat(21 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1387 / w) - offsetX, y: CGFloat(42 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1463 / w) - offsetX, y: CGFloat(65 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1536 / w) - offsetX, y: CGFloat(81 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1579 / w) - offsetX, y: CGFloat(96 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1631 / w) - offsetX, y: CGFloat(110 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1690 / w) - offsetX, y: CGFloat(140 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1734 / w) - offsetX, y: CGFloat(175 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1765 / w) - offsetX, y: CGFloat(222 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1783 / w) - offsetX, y: CGFloat(275 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1786 / w) - offsetX, y: CGFloat(307 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1781 / w) - offsetX, y: CGFloat(352 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1781 / w) - offsetX, y: CGFloat(429 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1765 / w) - offsetX, y: CGFloat(487 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1748 / w) - offsetX, y: CGFloat(540 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1740 / w) - offsetX, y: CGFloat(579 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1745 / w) - offsetX, y: CGFloat(608 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1765 / w) - offsetX, y: CGFloat(629 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1786 / w) - offsetX, y: CGFloat(633 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1801 / w) - offsetX, y: CGFloat(619 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1811 / w) - offsetX, y: CGFloat(593 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1819 / w) - offsetX, y: CGFloat(553 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1831 / w) - offsetX, y: CGFloat(514 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1835 / w) - offsetX, y: CGFloat(474 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1845 / w) - offsetX, y: CGFloat(413 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1847 / w) - offsetX, y: CGFloat(358 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1852 / w) - offsetX, y: CGFloat(313 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1858 / w) - offsetX, y: CGFloat(278 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1863 / w) - offsetX, y: CGFloat(226 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1859 / w) - offsetX, y: CGFloat(193 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1870 / w) - offsetX, y: CGFloat(155 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1874 / w) - offsetX, y: CGFloat(127 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1888 / w) - offsetX, y: CGFloat(101 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1922 / w) - offsetX, y: CGFloat(72 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1965 / w) - offsetX, y: CGFloat(48 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(1997 / w) - offsetX, y: CGFloat(33 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2049 / w) - offsetX, y: CGFloat(25 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2094 / w) - offsetX, y: CGFloat(22 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2499 / w) - offsetX, y: CGFloat(17 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2877 / w) - offsetX, y: CGFloat(11 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3030 / w) - offsetX, y: CGFloat(19 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3130 / w) - offsetX, y: CGFloat(7 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3221 / w) - offsetX, y: CGFloat(13 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3306 / w) - offsetX, y: CGFloat(12 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3392 / w) - offsetX, y: CGFloat(29 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3411 / w) - offsetX, y: CGFloat(69 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3424 / w) - offsetX, y: CGFloat(122 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3434 / w) - offsetX, y: CGFloat(154 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3405 / w) - offsetX, y: CGFloat(205 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3377 / w) - offsetX, y: CGFloat(260 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3354 / w) - offsetX, y: CGFloat(313 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3324 / w) - offsetX, y: CGFloat(380 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3292 / w) - offsetX, y: CGFloat(446 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3284 / w) - offsetX, y: CGFloat(492 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3308 / w) - offsetX, y: CGFloat(565 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3321 / w) - offsetX, y: CGFloat(610 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3330 / w) - offsetX, y: CGFloat(643 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3324 / w) - offsetX, y: CGFloat(662 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3316 / w) - offsetX, y: CGFloat(675 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3190 / w) - offsetX, y: CGFloat(679 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3067 / w) - offsetX, y: CGFloat(678 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3001 / w) - offsetX, y: CGFloat(673 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2934 / w) - offsetX, y: CGFloat(664 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2913 / w) - offsetX, y: CGFloat(634 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2942 / w) - offsetX, y: CGFloat(600 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2983 / w) - offsetX, y: CGFloat(552 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3024 / w) - offsetX, y: CGFloat(516 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3057 / w) - offsetX, y: CGFloat(481 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3079 / w) - offsetX, y: CGFloat(437 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3096 / w) - offsetX, y: CGFloat(417 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3121 / w) - offsetX, y: CGFloat(359 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3122 / w) - offsetX, y: CGFloat(312 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3131 / w) - offsetX, y: CGFloat(256 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3155 / w) - offsetX, y: CGFloat(204 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3191 / w) - offsetX, y: CGFloat(183 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3232 / w) - offsetX, y: CGFloat(172 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3248 / w) - offsetX, y: CGFloat(150 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3240 / w) - offsetX, y: CGFloat(128 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3225 / w) - offsetX, y: CGFloat(118 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3192 / w) - offsetX, y: CGFloat(114 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3155 / w) - offsetX, y: CGFloat(120 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3102 / w) - offsetX, y: CGFloat(148 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3089 / w) - offsetX, y: CGFloat(161 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3080 / w) - offsetX, y: CGFloat(181 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3068 / w) - offsetX, y: CGFloat(227 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3075 / w) - offsetX, y: CGFloat(300 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3070 / w) - offsetX, y: CGFloat(354 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3055 / w) - offsetX, y: CGFloat(403 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3031 / w) - offsetX, y: CGFloat(438 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2998 / w) - offsetX, y: CGFloat(465 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2963 / w) - offsetX, y: CGFloat(497 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2921 / w) - offsetX, y: CGFloat(524 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2873 / w) - offsetX, y: CGFloat(541 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2827 / w) - offsetX, y: CGFloat(579 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2779 / w) - offsetX, y: CGFloat(581 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2736 / w) - offsetX, y: CGFloat(597 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2691 / w) - offsetX, y: CGFloat(618 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2626 / w) - offsetX, y: CGFloat(627 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2537 / w) - offsetX, y: CGFloat(608 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2455 / w) - offsetX, y: CGFloat(600 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2409 / w) - offsetX, y: CGFloat(590 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2388 / w) - offsetX, y: CGFloat(590 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2384 / w) - offsetX, y: CGFloat(640 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2409 / w) - offsetX, y: CGFloat(674 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2465 / w) - offsetX, y: CGFloat(696 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2504 / w) - offsetX, y: CGFloat(724 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2601 / w) - offsetX, y: CGFloat(746 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2684 / w) - offsetX, y: CGFloat(757 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2749 / w) - offsetX, y: CGFloat(766 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2818 / w) - offsetX, y: CGFloat(772 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2878 / w) - offsetX, y: CGFloat(764 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(2944 / w) - offsetX, y: CGFloat(748 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3031 / w) - offsetX, y: CGFloat(738 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3098 / w) - offsetX, y: CGFloat(745 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3232 / w) - offsetX, y: CGFloat(766 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3286 / w) - offsetX, y: CGFloat(771 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3366 / w) - offsetX, y: CGFloat(774 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3399 / w) - offsetX, y: CGFloat(767 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3428 / w) - offsetX, y: CGFloat(740 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3434 / w) - offsetX, y: CGFloat(718 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3421 / w) - offsetX, y: CGFloat(687 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3407 / w) - offsetX, y: CGFloat(656 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3387 / w) - offsetX, y: CGFloat(591 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3403 / w) - offsetX, y: CGFloat(528 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3409 / w) - offsetX, y: CGFloat(450 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3430 / w) - offsetX, y: CGFloat(406 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3431 / w) - offsetX, y: CGFloat(358 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3457 / w) - offsetX, y: CGFloat(305 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3475 / w) - offsetX, y: CGFloat(247 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3491 / w) - offsetX, y: CGFloat(205 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3523 / w) - offsetX, y: CGFloat(156 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3550 / w) - offsetX, y: CGFloat(110 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3566 / w) - offsetX, y: CGFloat(63 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3563 / w) - offsetX, y: CGFloat(24 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(3550 / w) - offsetX, y: CGFloat(1 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(10 / w) - offsetX, y: CGFloat(3 / w) - offsetY));
        path3.addLine(to: CGPoint(x: CGFloat(8 / w) - offsetX, y: CGFloat(388 / w) - offsetY));
        path3.closeSubpath()

        let path4 = CGMutablePath()
        path4.move(to: CGPoint(x: CGFloat(14 / w) - offsetX, y: CGFloat(812 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(10 / w) - offsetX, y: CGFloat(779 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(67 / w) - offsetX, y: CGFloat(753 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(193 / w) - offsetX, y: CGFloat(779 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(283 / w) - offsetX, y: CGFloat(781 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(401 / w) - offsetX, y: CGFloat(773 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(455 / w) - offsetX, y: CGFloat(721 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(481 / w) - offsetX, y: CGFloat(689 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(539 / w) - offsetX, y: CGFloat(649 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(585 / w) - offsetX, y: CGFloat(575 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(613 / w) - offsetX, y: CGFloat(500 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(625 / w) - offsetX, y: CGFloat(448 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(657 / w) - offsetX, y: CGFloat(424 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(713 / w) - offsetX, y: CGFloat(453 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(718 / w) - offsetX, y: CGFloat(500 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(676 / w) - offsetX, y: CGFloat(571 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(665 / w) - offsetX, y: CGFloat(628 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(649 / w) - offsetX, y: CGFloat(689 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(647 / w) - offsetX, y: CGFloat(743 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(636 / w) - offsetX, y: CGFloat(815 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(661 / w) - offsetX, y: CGFloat(864 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(785 / w) - offsetX, y: CGFloat(895 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(932 / w) - offsetX, y: CGFloat(900 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1108 / w) - offsetX, y: CGFloat(892 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1203 / w) - offsetX, y: CGFloat(862 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1249 / w) - offsetX, y: CGFloat(820 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1265 / w) - offsetX, y: CGFloat(761 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1294 / w) - offsetX, y: CGFloat(702 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1315 / w) - offsetX, y: CGFloat(657 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1335 / w) - offsetX, y: CGFloat(599 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1355 / w) - offsetX, y: CGFloat(515 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1366 / w) - offsetX, y: CGFloat(461 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1387 / w) - offsetX, y: CGFloat(442 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1412 / w) - offsetX, y: CGFloat(439 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1428 / w) - offsetX, y: CGFloat(463 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1403 / w) - offsetX, y: CGFloat(527 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1374 / w) - offsetX, y: CGFloat(617 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1356 / w) - offsetX, y: CGFloat(692 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1325 / w) - offsetX, y: CGFloat(769 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1320 / w) - offsetX, y: CGFloat(810 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1371 / w) - offsetX, y: CGFloat(855 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1422 / w) - offsetX, y: CGFloat(890 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1502 / w) - offsetX, y: CGFloat(911 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1557 / w) - offsetX, y: CGFloat(926 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1615 / w) - offsetX, y: CGFloat(922 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1691 / w) - offsetX, y: CGFloat(923 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(1677 / w) - offsetX, y: CGFloat(930 / w) - offsetY));
        path4.addLine(to: CGPoint(x: CGFloat(700 / w) - offsetX, y: CGFloat(930 / w) - offsetY));

        path4.closeSubpath()

        let path5 = CGMutablePath()
        path5.move(to: CGPoint(x: CGFloat(1890 / w) - offsetX, y: CGFloat(934 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2013 / w) - offsetX, y: CGFloat(922 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2114 / w) - offsetX, y: CGFloat(899 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2139 / w) - offsetX, y: CGFloat(822 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2165 / w) - offsetX, y: CGFloat(708 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2161 / w) - offsetX, y: CGFloat(653 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2158 / w) - offsetX, y: CGFloat(580 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2176 / w) - offsetX, y: CGFloat(498 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2226 / w) - offsetX, y: CGFloat(468 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2241 / w) - offsetX, y: CGFloat(440 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2307 / w) - offsetX, y: CGFloat(431 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2388 / w) - offsetX, y: CGFloat(408 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2426 / w) - offsetX, y: CGFloat(390 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2506 / w) - offsetX, y: CGFloat(393 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2590 / w) - offsetX, y: CGFloat(398 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2679 / w) - offsetX, y: CGFloat(399 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2716 / w) - offsetX, y: CGFloat(390 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2742 / w) - offsetX, y: CGFloat(334 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2772 / w) - offsetX, y: CGFloat(281 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2773 / w) - offsetX, y: CGFloat(208 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2737 / w) - offsetX, y: CGFloat(162 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2707 / w) - offsetX, y: CGFloat(137 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2724 / w) - offsetX, y: CGFloat(118 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2784 / w) - offsetX, y: CGFloat(127 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2838 / w) - offsetX, y: CGFloat(147 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2865 / w) - offsetX, y: CGFloat(193 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2883 / w) - offsetX, y: CGFloat(284 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2847 / w) - offsetX, y: CGFloat(333 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2799 / w) - offsetX, y: CGFloat(407 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2701 / w) - offsetX, y: CGFloat(439 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2611 / w) - offsetX, y: CGFloat(441 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2543 / w) - offsetX, y: CGFloat(445 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2494 / w) - offsetX, y: CGFloat(427 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2399 / w) - offsetX, y: CGFloat(445 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2343 / w) - offsetX, y: CGFloat(458 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2284 / w) - offsetX, y: CGFloat(470 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2224 / w) - offsetX, y: CGFloat(497 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2213 / w) - offsetX, y: CGFloat(572 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2210 / w) - offsetX, y: CGFloat(676 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2197 / w) - offsetX, y: CGFloat(738 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2229 / w) - offsetX, y: CGFloat(794 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2322 / w) - offsetX, y: CGFloat(828 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2401 / w) - offsetX, y: CGFloat(863 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2467 / w) - offsetX, y: CGFloat(877 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2515 / w) - offsetX, y: CGFloat(882 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2537 / w) - offsetX, y: CGFloat(864 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2592 / w) - offsetX, y: CGFloat(874 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2635 / w) - offsetX, y: CGFloat(887 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2677 / w) - offsetX, y: CGFloat(887 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2715 / w) - offsetX, y: CGFloat(899 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2764 / w) - offsetX, y: CGFloat(907 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2836 / w) - offsetX, y: CGFloat(904 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2886 / w) - offsetX, y: CGFloat(899 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(2952 / w) - offsetX, y: CGFloat(896 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3032 / w) - offsetX, y: CGFloat(909 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3081 / w) - offsetX, y: CGFloat(892 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3160 / w) - offsetX, y: CGFloat(893 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3253 / w) - offsetX, y: CGFloat(904 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3325 / w) - offsetX, y: CGFloat(900 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3409 / w) - offsetX, y: CGFloat(904 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3469 / w) - offsetX, y: CGFloat(911 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3538 / w) - offsetX, y: CGFloat(902 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3618 / w) - offsetX, y: CGFloat(881 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3638 / w) - offsetX, y: CGFloat(810 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3629 / w) - offsetX, y: CGFloat(725 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3611 / w) - offsetX, y: CGFloat(652 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3587 / w) - offsetX, y: CGFloat(611 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3569 / w) - offsetX, y: CGFloat(584 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3572 / w) - offsetX, y: CGFloat(551 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3591 / w) - offsetX, y: CGFloat(527 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3613 / w) - offsetX, y: CGFloat(496 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3659 / w) - offsetX, y: CGFloat(466 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3730 / w) - offsetX, y: CGFloat(405 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3743 / w) - offsetX, y: CGFloat(402 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3733 / w) - offsetX, y: CGFloat(479 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3717 / w) - offsetX, y: CGFloat(684 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3709 / w) - offsetX, y: CGFloat(861 / w) - offsetY));
        path5.addLine(to: CGPoint(x: CGFloat(3650 / w) - offsetX, y: CGFloat(922 / w) - offsetY));

        path5.closeSubpath()

        let path6 = CGMutablePath()
        path6.move(to: CGPoint(x: CGFloat(1515 / w) - offsetX, y: CGFloat(768 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1506 / w) - offsetX, y: CGFloat(736 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1547 / w) - offsetX, y: CGFloat(735 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1701 / w) - offsetX, y: CGFloat(786 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1757 / w) - offsetX, y: CGFloat(796 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1880 / w) - offsetX, y: CGFloat(772 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1934 / w) - offsetX, y: CGFloat(729 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1974 / w) - offsetX, y: CGFloat(610 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1996 / w) - offsetX, y: CGFloat(508 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2021 / w) - offsetX, y: CGFloat(393 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2037 / w) - offsetX, y: CGFloat(342 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2049 / w) - offsetX, y: CGFloat(288 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2071 / w) - offsetX, y: CGFloat(234 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2139 / w) - offsetX, y: CGFloat(209 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2294 / w) - offsetX, y: CGFloat(202 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2426 / w) - offsetX, y: CGFloat(193 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2480 / w) - offsetX, y: CGFloat(186 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2502 / w) - offsetX, y: CGFloat(207 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2485 / w) - offsetX, y: CGFloat(231 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2413 / w) - offsetX, y: CGFloat(241 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2129 / w) - offsetX, y: CGFloat(250 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2080 / w) - offsetX, y: CGFloat(320 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2072 / w) - offsetX, y: CGFloat(383 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2044 / w) - offsetX, y: CGFloat(432 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2032 / w) - offsetX, y: CGFloat(494 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2021 / w) - offsetX, y: CGFloat(577 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(2005 / w) - offsetX, y: CGFloat(663 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1984 / w) - offsetX, y: CGFloat(743 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1964 / w) - offsetX, y: CGFloat(777 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1892 / w) - offsetX, y: CGFloat(803 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1807 / w) - offsetX, y: CGFloat(819 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1748 / w) - offsetX, y: CGFloat(827 / w) - offsetY));
        path6.addLine(to: CGPoint(x: CGFloat(1657 / w) - offsetX, y: CGFloat(816 / w) - offsetY));

        path6.closeSubpath()

        return SKPhysicsBody.init(bodies: [SKPhysicsBody(edgeLoopFrom: path1), SKPhysicsBody(edgeLoopFrom: path2), SKPhysicsBody(edgeLoopFrom: path3),
                                           SKPhysicsBody(edgeLoopFrom: path4), SKPhysicsBody(edgeLoopFrom: path5), SKPhysicsBody(edgeLoopFrom: path6)
        ])
    }
}
