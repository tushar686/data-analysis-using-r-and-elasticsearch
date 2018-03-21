rainbowColor = 12
fromSubmissionDate="2013-01-01"
toSubmissionDate="2013-12-31"

# record count by years
reportCountByYear= getReportCountOverDateRange('year', 'yyy')
barplot(as.numeric(reportCountByYear[,2]), main="ReportCount", xlab="Month", ylab="Count", names.arg=paste(reportCountByYear[,1]), col=rainbow(rainbowColor) )
legend("topleft", legend=paste(reportCountByYear[,1]), fill=rainbow(rainbowColor))
# record count by month for a 
reportCountByMonth= getReportCountOverDateRange('month', 'MM-yyy')
barplot(as.numeric(reportCountByMonth[,2]), main="ReportCount", xlab="Month", ylab="Count", names.arg=paste(reportCountByMonth[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(reportCountByMonth[,1]), fill=rainbow(rainbowColor))

nx = 31; ny = 31
x = seq(-1, 1, length = nx)
y = seq(-1, 1, length = ny)
z = outer(x, y, function(x,y) -x^2  -y^2)
z_col = outer(x, y, function(x,y) x^2)
hgt = 0.25 * (z_col[-nx,-ny] + z_col[-1,-ny] + z_col[-nx,-1] + z_col[-1,-1])
hgt = (hgt - min(hgt))/ (max(hgt) - min(hgt))

persp(x, y, z, col = gray(1 - hgt))
persp(x, y, z, col=cm.colors(31)[floor(31*hgt+1)], theta=-35, phi=10)


