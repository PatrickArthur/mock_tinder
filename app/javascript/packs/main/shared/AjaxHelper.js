const AjaxHelper = (url, obj, val) => {
    fetch(url)
      .then(res => res.json())
      .then(
        (result) => {
          obj.setState({
            isLoaded: true,
            [val]: result
          });
        },
        (error) => {
          obj.setState({
            isLoaded: true,
            error
          });
        }
      );
}

export default AjaxHelper;

