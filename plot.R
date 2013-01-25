library(RSvgDevice)

plotrank <- function(datafile, outfiletype, topup=TRUE)
{
    df <- read.table(datafile, sep=",")
    x <- strptime(df$V2, "%Y/%m/%d %H:%M:%S")
    y <- df$V3
    # 数値の大きい方を上にするか、小さい方を上にするかを指定
    if (topup) {
      yl = c(ylimmax(max(y, na.rm=TRUE)), 1)
    } else {
      yl = c(1, ylimmax(max(y, na.rm=TRUE)))
    }
    plot(x, y, type="l", ylim=yl, xlab="datetime", ylab="rank", xaxt="n", sub=paste("last update:", max(x), " (", outfiletype, ")", sep=""))
    par(xaxt="s")
    r <- as.POSIXct(round(range(x), "days"))
    axis.POSIXct(1, at=seq(r[1],r[2], by="1 day"), format="%m/%d")
}

ylimmax <- function(ymax)
{
  ylm <- 10
  while(ylm < ymax) {
    ylm <- ylm * 10
    while(ylm >= ymax * 2) {
      ylm <- ylm / 2
    }
  }
  return(ylm)
}

doplotrank <- function(asbn, datadir, outdir, outfiletype, topup)
{
  ## グラフの上下を逆にするときは出力ファイル名の拡張子前に「r」を付ける（例:475981339Xr.svg）
  if (topup == FALSE) {
    fname <- paste(asbn, "r", sep="")
  } else {
    fname <- asbn
  }
  ## 出力タイプ（SVGまたはPNG）の設定
  if (outfiletype == "PNG") {
    png(paste(outdir, "/", fname, ".png", sep=""), type="cairo", width=720, height=576)
  } else if (outfiletype == "SVG") {
    devSVG(paste(outdir, "/", fname, ".svg", sep=""))
  }
  ## グラフをファイルへ出力
  plotrank(paste(datadir, "/", asbn, ".csv", sep=""), outfiletype, topup)
  invisible(dev.off())
}

args <- commandArgs(trailingOnly = TRUE)
for (ftype in c("SVG", "PNG")) {
  for (utop in c(TRUE, FALSE)) {
    doplotrank(args[1], args[2], args[3], ftype, utop)
  }
}
