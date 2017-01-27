# encoding: utf-8
require 'carousel/selector'

class CarouselPromotionsCreatorForMailer < BaseService

  def call
    promotions = Promotion.where(id: params[:promotions_ids])
    to_html(promotions)
  end

  private

  def to_html(promotions)
    promotions_html = ''
    promotions.each do |promotion|
      promotions_html += "
        <table align='left' border='0' cellpadding='0' cellspacing='0' width='200' class='columnWrapper'>
          <tr>
            <td valign='top' class='columnContainer'><table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnCaptionBlock'>
              <tbody class='mcnCaptionBlockOuter'>
                <tr>
                  <td class='mcnCaptionBlockInner' valign='top' style='padding:9px;'>

                    <table align='left' border='0' cellpadding='0' cellspacing='0' class='mcnCaptionBottomContent' width='false'>
                      <tbody>
                        <tr>
                          <td class='mcnCaptionBottomImageContent' align='center' valign='top' style='padding:0 9px 9px 9px;'>
                            <a href='#{PromotionUrlGenerator.new(promotion: promotion, patent: params[:patent], kms: params[:kms]).call}' title='' class='' target='_blank'>
                              <img alt='' src='#{promotion.image_url}' width='164' style='max-width:185px;' class='mcnImage'>
                            </a>
                          </td>
                        </tr>
                        <tr>
                          <td class='mcnTextContent' valign='top' style='padding:0 9px 0 9px;' width='164'>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                   </td>
                  </tr>
                </tbody>
              </table>
              <table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnButtonBlock' style='min-width:100%;'>
                <tbody class='mcnButtonBlockOuter'>
                  <tr>
                    <td style='padding-top:0; padding-right:18px; padding-bottom:18px; padding-left:18px;' valign='top' align='center' class='mcnButtonBlockInner'>
                      <table border='0' cellpadding='0' cellspacing='0' width='100%' class='mcnButtonContentContainer' style='border-collapse: separate !important;border-radius: 0px;background-color: #EED925;'>
                        <tbody>
                          <tr>
                            <td align='center' valign='middle' class='mcnButtonContent' style='font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 16px; padding: 15px;'>
                              <a class='mcnButton ' title='VER PROMOCIÓN' href='#{PromotionUrlGenerator.new(promotion: promotion, patent: params[:patent], kms: params[:kms]).call}' target='_blank' style='font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #06407F;'>VER PROMOCIÓN</a>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
        </table>
      "
    end
    promotions_html
  end

end
