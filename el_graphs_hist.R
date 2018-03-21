rainbowColor = 12

# record count by years
fromSubmissionDate="2006-01-01"
toSubmissionDate="2013-12-31"
reportCountByYear= getReportCountOverDateRange('year', 'yyy')
barplot(as.numeric(reportCountByYear[,2]), main="ReportCount", xlab="Month", ylab="Count", names.arg=paste(reportCountByYear[,1]), col=rainbow(rainbowColor) )
legend("topleft", legend=paste(reportCountByYear[,1]), fill=rainbow(rainbowColor))

# record count by month for a
fromSubmissionDate="2013-01-01"
toSubmissionDate="2013-12-31"
reportCountByMonth= getReportCountOverDateRange('month', 'MM-yyy')
barplot(as.numeric(reportCountByMonth[,2]), main="ReportCount", xlab="Month", ylab="Count", names.arg=paste(reportCountByMonth[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(reportCountByMonth[,1]), fill=rainbow(rainbowColor))