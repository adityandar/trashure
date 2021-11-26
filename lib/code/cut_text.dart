String cutText(int cutoff, String myString) {
  print(myString.length);
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}
