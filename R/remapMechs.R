#' @export
#' @title Function which converts mechanism codes, names or shortnames to UIDs
#' 
#' @description remapMechs should be supplied a vector of data mechanisms (names,codes or shortnames)
#' along with the other required paramaters. It will return a vector of UIDs.
#' 
#'
#' @param mechs_in A vector of data element identifiers (codes, names or shortNames)
#' @param mode_in Should be one of code, name or id. This is the class we are mapping from.
#' @param mode_out Should be one of code,name or id. This is the class we are mapping to.
#' @param organisationUnit The UID of the operating unit.
#' @return Returns a vector of mechanism UIDs
#' @note
#' remapMechs(foo,"https://www.datim.org","admin","district","code","Ab12345678")
#' will remap mechanisms specified as codes to UIDs
remapMechs<-function(mechs_in,organisationUnit,mode_in="code",mode_out="id") {
  is_valid_mode<- (mode_in %in% c("code","name","id") ) & (mode_out %in% c("code","name","id") )
  if ( is_valid_mode == FALSE )  { print("Not a valid mode. Must be one of code,name or id"); stop() }
  mechs<-getMechanismsMap(organisationUnit)
  cmd<-paste("plyr::mapvalues(mechs_in,mechs$",mode_in,",mechs$",mode_out,",warn_missing = FALSE)")
  as.character(eval(parse(text=cmd))) }