# http://stackoverflow.com/questions/115426/algorithm-to-detect-intersection-of-two-rectangles
class Intersector
  def self.intersects(pieceA, pieceB)
    rect = Struct.new(
        :x, # the center in x axis
        :y, # the center in y axis
        :width,
        :height
    )
    rectA = rect.new(pieceA.x + (pieceA.width/2),
                     pieceA.y + (pieceA.height/2),
                     pieceA.width,
                     pieceA.height)
    rectB = rect.new(pieceB.x + (pieceB.width/2),
                     pieceB.y + (pieceB.height/2),
                     pieceB.width,
                     pieceB.height)

    (rectA.x - rectB.x).abs < ((rectA.width + rectB.width).abs / 2) \
      and ((rectA.y - rectB.y).abs < ((rectA.height + rectB.height).abs / 2))
  end
end