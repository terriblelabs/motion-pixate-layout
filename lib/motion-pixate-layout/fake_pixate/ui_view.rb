unless defined?(PXEngine)
  class UIView
    def styleId; @styleId; end
    def styleId=(styleId); @styleId = styleId; end

    def styleClass; @styleClass; end
    def styleClass=(styleClass); @styleClass = styleClass; end

    def updateStyles; @updateStyles; end
    def updateStyles=(updateStyles); @updateStyles = updateStyles; end
  end
end
