import React from "react"
import PropTypes from "prop-types"
class Message extends React.Component {
  render () {
    return (
      <aside className="message w-auto my-1">
		    <small className="text-muted d-block ml-5 d-none">{this.props.sender}</small>
		    <div className={this.props.position + " d-flex"}>
		        <img data-toggle="tooltip" data-placement="bottom" title="" className="btn btn-sm btn-float shadow-none border border-info" src={this.props.avatar} data-original-title={this.props.sender}/>
		        <div data-toggle="tooltip" data-placement="bottom" data-container="body" title="" className="mx-1" data-original-title={this.props.created_at}>
		            <div className={'bg-' + this.props.color + ' content p-2 br-25 text-' + this.props.direction}>
		                {this.props.content}
		            </div>
		        </div>
		        <div className={'icons d-sm-none d-md-flex' + this.props.position}>
		            <a data-toggle="tooltip" data-placement="bottom" title="" className="btn btn-sm btn-float shadow-none" href="#react" data-original-title="React"><i className="material-icons">insert_emoticon</i></a>
		            <a data-toggle="tooltip" data-placement="bottom" title="" className="btn btn-sm btn-float shadow-none" href="#reply" data-original-title="Reply"><i className="material-icons">reply</i></a>
		            <a data-toggle="tooltip" data-placement="bottom" title="" className="btn btn-sm btn-float shadow-none" href="#more" data-original-title="More"><i className="material-icons">more_horiz</i></a>
		        </div>
		    </div>
			</aside>
    );
  }
}

Message.propTypes = {
  content: PropTypes.string
};
export default Message
