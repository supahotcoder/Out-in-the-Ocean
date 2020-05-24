//
//  BodyPaths.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 14/05/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class BodyPaths {
    
    
    class func getPhysicsBodyOf(textureName: String, sprite: SKSpriteNode) -> SKPhysicsBody?{
        switch textureName{
        case "boundaries1_2":
            return boundaries1_2(sprite: sprite)
        case "wander":
            return wanderBody(sprite: sprite)
        default:
            return SKPhysicsBody(rectangleOf: sprite.size)
        }
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

    private class func boundaries1_2(sprite: SKSpriteNode) -> SKPhysicsBody? {
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
