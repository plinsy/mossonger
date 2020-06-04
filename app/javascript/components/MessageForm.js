import React from "react"
import PropTypes from "prop-types"
import Messages from './Messages'
class MessageForm extends React.Component {
    
    handleKeyPress = (e) => {
        if (e.key == "Enter") {
    		event.preventDefault()
            console.log(event.target.value)
            this.msgFormRef.submit()
        }
    }

    render() {
        return (
            <section className="col-12 col-sm-12 col-md-11 offset-md-3 position-fixed px-0 w-100 bottom-0-p left-0-p">
			    <div id="add-cancel-icons" className="d-md-none shadow-sm p-3 collapse bg-white">
			        <div className="justify-content-between d-flex">
			            <a className="" href="#create-a-poll-icon"><i className="material-icons">poll</i></a>
			            <a className="" href="#take-a-picture"><i className="material-icons">camera_alt</i></a>
			            <a className="" href="#play-a-game"><i className="material-icons">gamepad</i></a>
			            <a className="" href="#send-a-voice-clip"><i className="material-icons">mic</i></a>
			            <a className="" href="#choose-a-gif"><i className="material-icons">gif</i></a>
			            <a className="" href="#choose-a-sticker"><i className="material-icons">insert_drive_file</i></a>
			            <a className="" href="#add-files"><i className="material-icons">insert_photo</i></a>
			        </div>
			    </div>
			    <div className="card shadow-none border-0 border-top border-light">
			        <div className="card-footer pt-1 px-1 pb-0">
			            <form ref={el => this.msgFormRef = el} className="simple_form new_message" id="new-message-form" noValidate="novalidate" action={this.props.url} acceptCharset="UTF-8" data-remote="true" data-type="js" method="post">			            
				            <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
				            <div className="form-inputs">
				                <div className="d-flex justify-content-between align-items-center">
				                    <a data-first="add_circle" data-second="cancel" data-toggle="collapse" className="add-cancel-icons btn-sm d-md-none" href="#add-cancel-icons"><i className="material-icons">add_circle</i></a>
				                    <a data-first="add_circle" data-second="cancel" data-toggle="collapse" data-target=".hidden-icon" className="add-cancel-icons btn-sm d-none d-sm-none d-md-block" href="#add-cancel-icons"><i className="material-icons">add_circle</i></a>
				                    <a className="hidden-icon collapse fade btn-sm d-none d-sm-none collapse-md" href="#create-a-poll-icon"><i className="material-icons">poll</i></a>
				                    <a className="hidden-icon collapse fade btn-sm d-none d-sm-none collapse-md" href="#take-a-picture"><i className="material-icons">camera_alt</i></a>
				                    <a className="hidden-icon collapse fade btn-sm d-none d-sm-none collapse-md" href="#play-a-game"><i className="material-icons">gamepad</i></a>
				                    <a className="hidden-icon collapse fade btn-sm d-none d-sm-none collapse-md" href="#send-a-voice-clip"><i className="material-icons">mic</i></a>
				                    <a className="btn-sm d-none d-sm-none d-md-block" href="#choose-a-gif"><i className="material-icons">gif</i></a>
				                    <a className="btn-sm d-none d-sm-none d-md-block" href="#choose-a-sticker"><i className="material-icons">insert_drive_file</i></a>
				                    <a className="btn-sm d-none d-sm-none d-md-block" href="#add-files"><i className="material-icons">insert_photo</i></a>
				                    <div className="chip bg-transparent border mb-1 w-100">
				                        <textarea rows="1" placeholder="Type a message, @name..." id="" className="input w-100" name="message[content]" onKeyPress={this.handleKeyPress}></textarea>
				                        <a className="" href="#insert-emoji"><i className="material-icons">insert_emoticon</i></a>
				                    </div>
				                    <a className="shadow-none btn-sm" href="#change-emoji"><i className="material-icons">monetization_on</i></a>
				                    <button type="submit" className="btn btn-float d-none btn-sm">
				                        <i className="material-icons">send</i>
				                    </button>
				                </div>
				            </div>
						</form>        
					</div>
			    </div>
			</section>
        );
    }
}

MessageForm.propTypes = {
  authenticity_token: PropTypes.string
};

export default MessageForm